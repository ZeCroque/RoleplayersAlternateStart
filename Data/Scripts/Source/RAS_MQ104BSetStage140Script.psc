Scriptname RAS_MQ104BSetStage140Script extends ReferenceAlias

Event OnTriggerEnter(ObjectReference akActionRef)
    GetOwningQuest().SetStage(140)
EndEvent
