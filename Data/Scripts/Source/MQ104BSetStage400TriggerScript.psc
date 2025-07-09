Scriptname MQ104BSetStage400TriggerScript extends ReferenceAlias

Event OnTriggerEnter(ObjectReference akActionRef)
    If(GetOwningQuest().GetStage() == 390)
        GetOwningQuest().SetStage(400)
    EndIf
EndEvent