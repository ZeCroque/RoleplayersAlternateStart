Scriptname RAS_MQ101_LodgeEntryTriggerScript extends ReferenceAlias

Event OnTriggerEnter(ObjectReference akActionRef)
    If(akActionRef == Game.GetPlayer())
        If(GetOwningQuest().GetStageDone(20)) ;If its the non-starborn variant
            GetOwningQuest().SetStage(1510)
        Else
            GetOwningQuest().SetObjectiveCompleted(10)
            GetOwningQuest().SetObjectiveDisplayed(185)
        EndIf
        Clear()
    EndIf
EndEvent

