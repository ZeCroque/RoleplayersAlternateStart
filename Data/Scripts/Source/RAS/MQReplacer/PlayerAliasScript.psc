Scriptname RAS:MQReplacer:PlayerAliasScript extends ReferenceAlias

Message Property RAS_KeepArtifactMessage Mandatory Const Auto
LocationRefType Property LocStoryArtifactRoomReserveMarkerLocRef Mandatory Const Auto
GlobalVariable Property RAS_MQLevelThreshold Mandatory Const Auto
GlobalVariable Property RAS_MQTriggerChance Mandatory Const Auto
FormList Property RAS_ExcludedArtifactLocationsList Mandatory Const Auto
Quest Property RAS_MQReplacerIntroQuest Mandatory Const Auto

Function HandleArtifact(ObjectReference akArtifactRef)
  Self.AddInventoryEventFilter(akArtifactRef.GetBaseObject())
EndFunction

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
  If(GetOwningQuest().GetStage() < 10 && RAS_MQReplacerIntroQuest.GetStage() == 0 && akNewLoc && !akNewLoc.IsExplored() && akNewLoc && akNewLoc.HasRefType(LocStoryArtifactRoomReserveMarkerLocRef) && Game.GetPlayerLevel() >= RAS_MQLevelThreshold.GetValue() as Int)
    Int excludedListSize = RAS_ExcludedArtifactLocationsList.GetSize()
    Int i = 0
    Bool excluded = False
    While(i < excludedListSize)
      If(akNewLoc == RAS_ExcludedArtifactLocationsList.GetAt(i))
        excluded = True
        i = excludedListSize
      EndIf
      i += 1
    EndWhile

    If(!excluded)
      Int roll = Utility.RandomInt(1, 100)
      If(roll <= RAS_MQTriggerChance.GetValue() as Int)      
          (GetOwningQuest() as RAS:MQReplacer:MQReplacerScript).StartMQReplacer(akNewLoc)
      EndIf
    EndIf
  EndIf
EndEvent

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer, int aiTransferReason)
    RAS:MQReplacer:MQReplacerScript MQReplacerQuestScript = (GetOwningQuest() as RAS:MQReplacer:MQReplacerScript)
    If(MQReplacerQuestScript.Artifact01REF && aiTransferReason != 2) ;Checking just in case but normally we should never enter this if we sell the artifact
        RAS_KeepArtifactMessage.Show()
        GetReference().AddItem(MQReplacerQuestScript.Artifact01REFCopy, abSilent=True)
    EndIf
EndEvent