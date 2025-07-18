Scriptname MQ101SetStage1600TriggerAliasScript extends ReferenceAlias

Event OnTriggerEnter(ObjectReference akActionRef)
    GetOwningQuest().SetStage(1600)
    Clear()
EndEvent