Scriptname RAS:Debug:TestActivatorScript extends ObjectReference

Quest Property RAS_ArtifactGenerationQuest Mandatory Const Auto

Event OnActivate(ObjectReference akActionRef)
	;Debug
	;=====
	RAS_ArtifactGenerationQuest.Start()
	RAS:Debug:ArtifactGenerationQuestScript questScript = RAS_ArtifactGenerationQuest as RAS:Debug:ArtifactGenerationQuestScript
	Game.FastTravel(questScript.ArtifactLocationMarker.GetReference())
EndEvent

