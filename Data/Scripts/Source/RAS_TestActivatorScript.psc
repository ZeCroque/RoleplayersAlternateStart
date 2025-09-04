Scriptname RAS_TestActivatorScript extends ObjectReference

Quest Property RAS_ArtifactGenerationQuest Mandatory Const Auto

Event OnActivate(ObjectReference akActionRef)
	;Debug
	;=====
	RAS_ArtifactGenerationQuest.Start()
	RAS_ArtifactGenerationQuestScript questScript = RAS_ArtifactGenerationQuest as RAS_ArtifactGenerationQuestScript
	Game.FastTravel(questScript.ArtifactLocationMarker.GetReference())
EndEvent

