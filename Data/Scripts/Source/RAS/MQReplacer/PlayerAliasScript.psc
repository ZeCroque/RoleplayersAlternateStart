Scriptname RAS:MQReplacer:PlayerAliasScript extends ReferenceAlias

Message Property RAS_KeepArtifactMessage Mandatory Const Auto
Keyword Property PCM_ArtifactCave Mandatory Const Auto
GlobalVariable Property RAS_MQLevelThreshold Mandatory Const Auto
GlobalVariable Property RAS_MQTriggerChance Mandatory Const Auto

Function HandleArtifact(ObjectReference akArtifactRef)
  Self.AddInventoryEventFilter(akArtifactRef.GetBaseObject())
EndFunction

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
  If(GetOwningQuest().GetStage() < 10 && akNewLoc && !akNewLoc.IsExplored() && akNewLoc.HasKeyword(PCM_ArtifactCave) && Game.GetPlayerLevel() >= RAS_MQLevelThreshold.GetValue() as Int)
    Int roll = Utility.RandomInt(1, 100)
    If(roll <= RAS_MQTriggerChance.GetValue() as Int)
      RAS:MQReplacer:MQReplacerScript MQReplacerQuestScript = GetOwningQuest() as RAS:MQReplacer:MQReplacerScript
      MQReplacerQuestScript.ArtifactLocation.ForceLocationTo(akNewLoc)
      MQReplacerQuestScript.ArtifactLocation.RefillDependentAliases()
      MQReplacerQuestScript.SetStage(10)  
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