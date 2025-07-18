Scriptname RAS_MQ101SetStage1510TriggerScript extends ReferenceAlias

Event OnTriggerEnter(ObjectReference akActionRef)
    GetOwningQuest().SetStage(1510)
    Clear()
EndEvent