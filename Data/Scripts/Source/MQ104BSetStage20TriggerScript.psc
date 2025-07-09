Scriptname MQ104BSetStage20TriggerScript extends ReferenceAlias

Event OnTriggerEnter(ObjectReference akActionRef)
    If(GetOwningQuest().GetStage() == 15)
        GetOwningQuest().SetStage(20)
    EndIf
EndEvent