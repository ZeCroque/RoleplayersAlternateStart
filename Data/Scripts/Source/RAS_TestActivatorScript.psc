Scriptname RAS_TestActivatorScript extends ObjectReference

Quest Property RAS_ArtifactGenerationQuest Mandatory Const Auto
Quest Property RAS_NewGameManagerQuest Mandatory Const Auto
Message Property RAS_ChooseStartTypeMessage Mandatory Const Auto
Actor Property RAS_ShipServicesActorREF Mandatory Const Auto
Perk Property RAS_ShipVendorDiscountPerk Mandatory Const Auto

Event OnActivate(ObjectReference akActionRef)

	If(RAS_ChooseStartTypeMessage.Show() == 0)
		Game.GetPlayer().AddPerk(RAS_ShipVendorDiscountPerk)
		RegisterForMenuOpenCloseEvent("SpaceshipEditorMenu")
		(RAS_ShipServicesActorREF as RAS_ShipVendorScript).StartShipVending()
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
		Game.GetPlayer().RemovePerk(RAS_ShipVendorDiscountPerk)
		UnregisterForMenuOpenCloseEvent("SpaceshipEditorMenu")
	EndIf
EndEvent
