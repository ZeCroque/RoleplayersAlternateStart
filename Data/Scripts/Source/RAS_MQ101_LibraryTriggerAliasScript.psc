Scriptname RAS_MQ101_LibraryTriggerAliasScript extends ReferenceAlias

Scene Property RAS_MQ401_001_LodgeIntro Auto Const

Event OnTriggerEnter(ObjectReference akActionRef)
    If(akActionRef == Game.GetPlayer())
        If(GetOwningQuest().GetStageDone(20)) ;If its the non-starborn variant
            GetOwningQuest().SetStage(1600)
        Else
            RAS_MQ401_001_LodgeIntro.Start()
        EndIf
        Clear()
    EndIf
EndEvent