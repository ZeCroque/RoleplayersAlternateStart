Scriptname RAS:MQReplacer:MQReplacerIntroQuestScript extends Quest

Quest Property MQ_HunterPreMQ106 Mandatory Const Auto

Function RegisterForHunterQuest()
    RegisterForRemoteEvent(MQ_HunterPreMQ106, "OnStageSet")
EndFunction

Event OnQuestInit()
    RegisterForHunterQuest()
EndEvent

Event Quest.OnStageSet(Quest akSender, int auiStageID, int auiItemID)
    If(auiStageID  == 125)
        SetStage(1)
    EndIf
EndEvent