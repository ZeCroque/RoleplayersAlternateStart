Scriptname RAS:Debug:TestActivatorScript extends ObjectReference

Quest Property RAS_MQReplacerIntroQuest Mandatory Const Auto

Event OnActivate(ObjectReference akActionRef)
	If(!RAS_MQReplacerIntroQuest.IsRunning())
		RAS_MQReplacerIntroQuest.Start()
	Else
		RAS_MQReplacerIntroQuest.GetAlias(4).RefillAlias()
		RAS_MQReplacerIntroQuest.GetAlias(8).RefillAlias()
	EndIf
	Game.FastTravel((RAS_MQReplacerIntroQuest.GetAlias(8) as ReferenceAlias).GetReference())
EndEvent

