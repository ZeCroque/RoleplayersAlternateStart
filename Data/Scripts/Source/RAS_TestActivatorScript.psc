Scriptname RAS_TestActivatorScript extends ObjectReference

Quest Property RAS_ArtifactGenerationQuest Mandatory Const Auto
Quest Property RAS_NewGameManagerQuest Mandatory Const Auto
Message Property RAS_ChooseStartTypeMessage Mandatory Const Auto
Actor Property RAS_ShipServicesActorREF Mandatory Const Auto

Event OnActivate(ObjectReference akActionRef)

	If(RAS_ChooseStartTypeMessage.Show() == 0)
		(RAS_ShipServicesActorREF as RAS_ShipVendorScript).StartShipVending()
	Else
		RAS_ArtifactGenerationQuest.Start()
		RAS_ArtifactGenerationQuestScript questScript = RAS_ArtifactGenerationQuest as RAS_ArtifactGenerationQuestScript
		Game.FastTravel(questScript.ArtifactLocationMarker.GetReference())
	Endif
EndEvent
