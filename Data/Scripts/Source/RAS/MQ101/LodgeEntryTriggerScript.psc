Scriptname RAS:MQ101:LodgeEntryTriggerScript extends ReferenceAlias

Event OnCellLoad()
    If(GetOwningQuest().GetStageDone(20)) ;If its the non-starborn variant
        GetOwningQuest().SetStage(1510)
    Else
        GetOwningQuest().SetObjectiveCompleted(10)
        GetOwningQuest().SetObjectiveDisplayed(185)
    EndIf
    Clear()
EndEvent

