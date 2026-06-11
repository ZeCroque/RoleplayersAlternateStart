Scriptname RAS:NewGameManagerQuest:ChooseStartCellTriggerScript extends ObjectReference Const

Quest Property RAS_NewGameManagerQuest Mandatory Const Auto
Keyword Property AnimArchetypePlayer Mandatory Const Auto

Armor Property Clothes_GenWare_01 Mandatory Const Auto
Message Property RAS_CustomStartTutorialMessage Mandatory Const Auto
Armor Property Spacesuit_Constellation_01 Mandatory Const Auto
Armor Property Spacesuit_Constellation_Backpack_01 Mandatory Const Auto
Armor Property Spacesuit_Constellation_Helmet_01 Mandatory Const Auto
Armor Property Clothes_Miner_UtilitySuit Mandatory Const Auto
Outfit Property Outfit_Starborn Auto Const Mandatory
Message Property RAS_StartingStuffWarning Mandatory Const Auto
Message Property RAS_MissingSoundWarning Mandatory Const Auto

Event OnCellLoad()
    RAS:NewGameManagerQuest:NewGameManagerQuestScript managerQuest = RAS_NewGameManagerQuest as RAS:NewGameManagerQuest:NewGameManagerQuestScript

    Game.SetCharGenHUDMode(0)
    Game.SetInChargen(False, False, False)
    RAS_NewGameManagerQuest.SetActive()
    Game.GetPlayer().ChangeAnimArchetype(AnimArchetypePlayer)

    Game.GetPlayer().RemoveItem(Spacesuit_Constellation_01, abSilent = True)
    Game.GetPlayer().RemoveItem(Spacesuit_Constellation_Backpack_01, abSilent = True)
    Game.GetPlayer().RemoveItem(Spacesuit_Constellation_Helmet_01, abSilent = True)
    Game.GetPlayer().RemoveItem(Clothes_Miner_UtilitySuit, abSilent = True)

    Bool hasExtraGear = False
    If(Game.GetPlayer().GetItemCount() > 0)
        Game.GetPlayer().RemoveAllItems(managerQuest.RAS_StartingStuffContainer)
        hasExtraGear = True
    EndIf

    ;Add base gear    
    If(managerQuest.StarbornStart)
        Game.GetPlayer().SetOutfit(Outfit_Starborn)
        Game.GetPlayer().RemoveItem(Spacesuit_Constellation_01, abSilent = True)
        Game.GetPlayer().RemoveItem(Spacesuit_Constellation_Backpack_01, abSilent = True)
        Game.GetPlayer().RemoveItem(Spacesuit_Constellation_Helmet_01, abSilent = True)
        Game.GetPlayer().RemoveItem(Clothes_Miner_UtilitySuit, abSilent = True)
    EndIf
    Game.GetPlayer().AddItem(Clothes_GenWare_01, 1, True)
    Game.GetPlayer().EquipItem(Clothes_GenWare_01, false, true)
    
    managerQuest.StayBlack.Remove()
    managerQuest.InputLayer.Delete()    
    RAS_CustomStartTutorialMessage.Show()
    RAS_MissingSoundWarning.Show()
    If(hasExtraGear)
        RAS_StartingStuffWarning.ShowAsHelpMessage("", 10, 0, 1)
    EndIf

    Disable()
EndEvent
