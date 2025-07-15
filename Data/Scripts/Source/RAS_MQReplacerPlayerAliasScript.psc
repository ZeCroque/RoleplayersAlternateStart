Scriptname RAS_MQReplacerPlayerAliasScript extends ReferenceAlias

Message Property RAS_KeepArtifactMessage Mandatory Const Auto

Function HandleArtifact(ObjectReference akArtifactRef)
  Self.AddInventoryEventFilter(akArtifactRef.GetBaseObject())
EndFunction

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer, int aiTransferReason)
    RAS_MQReplacerQuestScript MQReplacerQuestScript = (GetOwningQuest() as RAS_MQReplacerQuestScript)
    If(MQReplacerQuestScript.Artifact01REF && aiTransferReason != 2) ;Checking just in case but normally we should never enter this if we sell the artifact
        RAS_KeepArtifactMessage.Show()
        GetReference().AddItem(MQReplacerQuestScript.Artifact01REF, abSilent=True)
    EndIf
EndEvent