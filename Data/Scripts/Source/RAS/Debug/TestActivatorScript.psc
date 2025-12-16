Scriptname RAS:Debug:TestActivatorScript extends ObjectReference

Quest Property RAS_ArtifactGenerationQuest Mandatory Const Auto
ObjectReference Property LC001VecteraLiftDoor Auto Const
Quest Property 	RAS_NewGameManagerQuest Mandatory Const Auto

Event OnActivate(ObjectReference akActionRef)
	RAS:Debug:ArtifactGenerationQuestScript questScript = RAS_ArtifactGenerationQuest as RAS:Debug:ArtifactGenerationQuestScript

	If(!RAS_ArtifactGenerationQuest.IsRunning())
		RAS_ArtifactGenerationQuest.Start()
	Else
		questScript.ArtifactLocation.RefillAlias()
		questScript.ArtifactLocationMarker.RefillAlias()
	EndIf
	Game.FastTravel(questScript.ArtifactLocationMarker.GetReference())
EndEvent

