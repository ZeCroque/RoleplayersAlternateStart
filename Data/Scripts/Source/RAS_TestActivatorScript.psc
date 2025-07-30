Scriptname RAS_TestActivatorScript extends ObjectReference

Quest Property RAS_ArtifactGenerationQuest Mandatory Const Auto
Quest Property RAS_NewGameManagerQuest Mandatory Const Auto
Message Property RAS_ChooseStartTypeMessage Mandatory Const Auto
Actor Property RAS_ShipServicesActorREF Mandatory Const Auto
Perk Property RAS_FreeShoppingPerk Mandatory Const Auto
Perk Property RAS_FullPriceShoppingPerk Mandatory Const Auto
Actor Property RAS_VendorREF Mandatory Const Auto
Message Property RAS_ChooseBudgetMessage Mandatory Const Auto
ObjectReference Property RAS_VendorContainerREF Mandatory Const Auto
MiscObject Property Credits Mandatory Const Auto

GlobalVariable Property RAS_LowBudget Mandatory Const Auto
GlobalVariable Property RAS_MediumBudget Mandatory Const Auto
GlobalVariable Property RAS_HighBudget Mandatory Const Auto

Event OnActivate(ObjectReference akActionRef)

	If(RAS_ChooseStartTypeMessage.Show() == 0)
		If(RAS_ChooseStartTypeMessage.Show() == 0)
			Int budget = RAS_ChooseBudgetMessage.Show()
			If(Budget < 4)
				Game.GetPlayer().RemoveAllItems(RAS_VendorContainerREF)
				If(budget < 3)
					Game.GetPlayer().AddPerk(RAS_FullPriceShoppingPerk)
					If(budget == 0)
						Game.GivePlayerCaps(RAS_LowBudget.GetValue() as Int)
					ElseIf(budget == 1)
						Game.GivePlayerCaps(RAS_MediumBudget.GetValue() as Int)
					Else
						Game.GivePlayerCaps(RAS_HighBudget.GetValue() as Int)
					EndIf
				Else
					Game.GetPlayer().AddPerk(RAS_FreeShoppingPerk)
					;Add credits (to sell maybe)
				Endif
				
				RAS_VendorContainerREF.RemoveItem(Credits, RAS_VendorContainerREF.GetItemCount(Credits))
				RAS_VendorContainerREF.AddItem(Credits, 5000)
				RAS_VendorREF.ShowBarterMenu()
				RegisterForMenuOpenCloseEvent("BarterMenu")
			Endif
		Else
			Game.GetPlayer().AddPerk(RAS_FreeShoppingPerk)
			RegisterForMenuOpenCloseEvent("SpaceshipEditorMenu")
			(RAS_ShipServicesActorREF as RAS_ShipVendorScript).StartShipVending()
		EndIf
	Else
		;Character choice done
		;=====================
		RAS_NewGameManagerQuest.SetStage(100)

		;If player has picked a ship, deletes the none ship (will prevent player alias events from firing)
		SpaceshipReference currentShip = (RAS_ShipServicesActorREF as RAS_ShipVendorScript).currentShip
		If(currentShip != (RAS_NewGameManagerQuest as RAS_NewGameManagerQuestScript).RAS_NoneShipReference) 
			(RAS_NewGameManagerQuest as RAS_NewGameManagerQuestScript).SetupPlayerShip(currentShip)
		EndIf

		;Debug
		;=====
		; RAS_ArtifactGenerationQuest.Start()
		; RAS_ArtifactGenerationQuestScript questScript = RAS_ArtifactGenerationQuest as RAS_ArtifactGenerationQuestScript
		; Game.FastTravel(questScript.ArtifactLocationMarker.GetReference())
	Endif
EndEvent

Event OnMenuOpenCloseEvent(string asMenuName, bool abOpening)
	If(!abOpening)
		If(asMenuName == "SpaceshipEditorMenu")
			Game.GetPlayer().RemovePerk(RAS_FreeShoppingPerk)
			UnregisterForMenuOpenCloseEvent("SpaceshipEditorMenu")
		Else
			Game.GetPlayer().RemovePerk(RAS_FreeShoppingPerk)
			Game.GetPlayer().RemovePerk(RAS_FullPriceShoppingPerk)
			UnregisterForMenuOpenCloseEvent("BarterMenu")
		EndIf
	EndIf
EndEvent
