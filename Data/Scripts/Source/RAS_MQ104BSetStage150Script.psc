Scriptname RAS_MQ104BSetStage150Script extends ReferenceAlias

Event OnTriggerEnter(ObjectReference akActionRef)
    GetOwningQuest().SetStage(150)
EndEvent