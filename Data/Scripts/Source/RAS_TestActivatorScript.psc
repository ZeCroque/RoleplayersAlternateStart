Scriptname RAS_TestActivatorScript extends ObjectReference

ObjectReference Property RAS_NoneShipReference Mandatory Const Auto
ObjectReference Property Frontier_ModularREF Mandatory Const Auto
Quest Property RAS_ArtifactGenerationQuest Mandatory Const Auto
ActorValue Property SpaceshipRegistration Mandatory Const Auto
Quest Property RAS_NewGameManagerQuest Mandatory Const Auto
Message Property RAS_ChooseStartTypeMessage Mandatory Const Auto

InputEnableLayer FastTravelInputLayer

Function RASDisableFastTravel()
    FastTravelInputLayer = InputEnableLayer.Create()
    FastTravelInputLayer.EnableFastTravel(False)
EndFunction

Function RASEnableFastTravel()
    If (FastTravelInputLayer != None)
		FastTravelInputLayer.EnableFastTravel(True)
		FastTravelInputLayer.Delete()
		FastTravelInputLayer = None
    EndIf
EndFunction

Event OnActivate(ObjectReference akActionRef)
	If(RAS_ChooseStartTypeMessage.Show() == 0)
		Game.AddPlayerOwnedShip(Frontier_ModularREF as SpaceshipReference) 
		Game.TrySetPlayerHomeSpaceShip(Frontier_ModularREF)
		Frontier_ModularREF.Enable()
	Else
		Game.AddPlayerOwnedShip(RAS_NoneShipReference as SpaceshipReference)
		Game.TrySetPlayerHomeSpaceShip(RAS_NoneShipReference)
		RAS_NoneShipReference.SetValue(SpaceshipRegistration, 1)
		;RASDisableFastTravel()
	EndIf

	; RAS_ArtifactGenerationQuest.Start()
	; RAS_ArtifactGenerationQuestScript questScript = RAS_ArtifactGenerationQuest as RAS_ArtifactGenerationQuestScript
	; Game.FastTravel(questScript.ArtifactLocationMarker.GetReference())
EndEvent
