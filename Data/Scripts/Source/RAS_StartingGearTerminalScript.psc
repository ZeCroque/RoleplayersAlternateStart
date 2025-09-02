Scriptname RAS_StartingGearTerminalScript extends ObjectReference Conditional

Message Property RAS_ChooseGearAgainMessage Mandatory Const Auto
ObjectReference Property RAS_VendorContainerREF Mandatory Const Auto
GlobalVariable Property RAS_CurrentBudget Mandatory Const Auto
MiscObject Property Credits Mandatory Const Auto
Perk Property RAS_FreeShoppingPerk Mandatory Const Auto
Perk Property RAS_FullPriceShoppingPerk Mandatory Const Auto
Actor Property RAS_VendorREF Mandatory Const Auto
Perk Property Skill_Commerce Mandatory Const Auto
ConditionForm Property RAS_HasCommerceRank2 Mandatory Const Auto
ConditionForm Property RAS_HasCommerceRank3 Mandatory Const Auto
ConditionForm Property RAS_HasCommerceRank4 Mandatory Const Auto
GlobalVariable Property RAS_LowBudget Mandatory Const Auto
GlobalVariable Property RAS_MediumBudget Mandatory Const Auto
GlobalVariable Property RAS_HighBudget Mandatory Const Auto
Armor Property Clothes_GenWare_01 Mandatory Const Auto

Quest Property RAS_NewGameManagerQuest Mandatory Const Auto

Bool Property KeepGearMode Auto Conditional

;Activation logic

Bool GearYetBought = False

Event OnLoad()
	BlockActivation()	
EndEvent

Event OnActivate(ObjectReference akActionRef)
    If(IsActivationBlocked())
        If(!GearYetBought)
            BlockActivation(false)
            Activate(akActionRef)
        Else
            Int choice = RAS_ChooseGearAgainMessage.Show()
            If(choice < 2)
                If(choice == 1)
                    Bool HasUndersuit = False
                    If(Game.GetPlayer().GetItemCount(Clothes_GenWare_01))
                        Game.GetPlayer().RemoveItem(Clothes_GenWare_01, 1, True)
                        HasUndersuit = True
                    EndIf
                    Game.GetPlayer().RemoveAllItems(RAS_VendorContainerREF)
                    If(HasUndersuit)
                        Game.GetPlayer().AddItem(Clothes_GenWare_01, 1, True)
                        Game.GetPlayer().EquipItem(Clothes_GenWare_01, false, true)
                    EndIf
                    RAS_CurrentBudget.SetValue(RAS_LowBudget.GetValue() as Int)
                    RAS_NewGameManagerQuest.UpdateCurrentInstanceGlobal(RAS_CurrentBudget)
                    KeepGearMode = False
                    GearYetBought = False
                Else
                    RAS_CurrentBudget.SetValue(Game.GetPlayer().GetItemCount(Credits))
                    RAS_NewGameManagerQuest.UpdateCurrentInstanceGlobal(RAS_CurrentBudget)
                    KeepGearMode = True
                EndIf
                BlockActivation(false)
                Activate(akActionRef)
            EndIf
        EndIf
    Else
        BlockActivation()
    EndIf
EndEvent

; Menu logic
Int perkRank = 0
Bool freeShopping = false

Function StartRegularShopping()
    perkRank = 0
    Actor playerRef = Game.GetPlayer()
    If(playerRef.HasPerk(Skill_Commerce))
        If(RAS_HasCommerceRank2.IsTrue())
            perkRank = 2
        ElseIf(RAS_HasCommerceRank3.IsTrue())
            perkRank = 3
        ElseIf(RAS_HasCommerceRank4.IsTrue())
            perkRank = 4
        Else
            perkRank = 1
        EndIf
    EndIf

    PlayerRef.RemovePerk(Skill_Commerce)
    PlayerRef.AddPerk(RAS_FullPriceShoppingPerk)
    freeShopping = false

    StartVending()
EndFunction

Function StartFreeShopping()
    Game.GetPlayer().AddPerk(RAS_FreeShoppingPerk)
    freeShopping = true

    StartVending()
EndFunction

Function StartVending()
    GearYetBought = True
    If(!KeepGearMode)
	    Game.GivePlayerCaps(RAS_CurrentBudget.GetValue() as Int)
    EndIf
	RAS_VendorContainerREF.RemoveItem(Credits, RAS_VendorContainerREF.GetItemCount(Credits))
	RAS_VendorContainerREF.AddItem(Credits, 5000)
	RAS_VendorREF.ShowBarterMenu()
	RegisterForMenuOpenCloseEvent("BarterMenu")
EndFunction

Event OnMenuOpenCloseEvent(string asMenuName, bool abOpening)
	If(!abOpening)
		If(freeShopping)
			Game.GetPlayer().RemovePerk(RAS_FreeShoppingPerk)
		Else
			Game.GetPlayer().RemovePerk(RAS_FullPriceShoppingPerk)
			Int i = 0
			While(i < perkRank)
				Game.GetPlayer().AddPerk(Skill_Commerce)
				i = i + 1
			EndWhile
		EndIf
		UnregisterForMenuOpenCloseEvent("BarterMenu")
	EndIf
EndEvent