Scriptname RAS_TestActivatorScript extends ObjectReference

Form Property RAS_NoneShip Mandatory Const Auto 
ObjectReference Property Frontier_ModularREF Mandatory Const Auto
Quest Property RAS_ArtifactGenerationQuest Mandatory Const Auto
ActorValue Property SpaceshipRegistration Mandatory Const Auto
Quest Property RAS_NewGameManagerQuest Mandatory Const Auto
Message Property RAS_ChooseStartTypeMessage Mandatory Const Auto
ObjectReference Property RAS_NewGameShipMarkerREF Mandatory Const Auto
Quest Property DialogueShipServices Mandatory Const Auto

InputEnableLayer FastTravelInputLayer

Event OnActivate(ObjectReference akActionRef)
	If(RAS_ChooseStartTypeMessage.Show() == 0)
		Game.AddPlayerOwnedShip(Frontier_ModularREF as SpaceshipReference) 
		Game.TrySetPlayerHomeSpaceShip(Frontier_ModularREF)
		Frontier_ModularREF.Enable()
	Else
		RAS_NewGameManagerQuestScript NewGameManagerQuestScript = (RAS_NewGameManagerQuest as RAS_NewGameManagerQuestScript)
		SpaceshipReference NoneShip  = RAS_NewGameShipMarkerREF.PlaceShipAtMe(RAS_NoneShip)
		NewGameManagerQuestScript.RAS_NoneShipReference = NoneShip
		Game.AddPlayerOwnedShip(NoneShip)
		Game.TrySetPlayerHomeSpaceShip(NoneShip)
		NoneShip.SetValue(SpaceshipRegistration, 1)
		NewGameManagerQuestScript.InputLayer = InputEnableLayer.Create()
		NewGameManagerQuestScript.InputLayer.EnableFastTravel(False)
		NewGameManagerQuestScript.PlayerShipless = True
		DialogueShipServices.Stop()
	EndIf

	; RAS_ArtifactGenerationQuest.Start()
	; RAS_ArtifactGenerationQuestScript questScript = RAS_ArtifactGenerationQuest as RAS_ArtifactGenerationQuestScript
	; Game.FastTravel(questScript.ArtifactLocationMarker.GetReference())
EndEvent
