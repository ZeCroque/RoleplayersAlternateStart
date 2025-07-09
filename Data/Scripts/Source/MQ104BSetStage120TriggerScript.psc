Scriptname MQ104BSetStage120TriggerScript extends ReferenceAlias

Event OnTriggerEnter(ObjectReference akActionRef)
    GetOwningQuest().SetStage(120)
EndEvent