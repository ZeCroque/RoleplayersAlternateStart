Scriptname RAS:MQReplacer:PlayerAliasScript extends ReferenceAlias

Message Property RAS_KeepArtifactMessage Mandatory Const Auto
LocationRefType Property LocStoryArtifactRoomReserveMarkerLocRef Mandatory Const Auto
GlobalVariable Property RAS_MQLevelThreshold Mandatory Const Auto
GlobalVariable Property RAS_MQTriggerChance Mandatory Const Auto
Quest Property RAS_NewGameManagerQuest Mandatory Const Auto
ActorValue Property RAS_MinerStart Mandatory Const Auto

Function HandleArtifact(ObjectReference akArtifactRef)
  Self.AddInventoryEventFilter(akArtifactRef.GetBaseObject())
EndFunction

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
  If(GetOwningQuest().GetStage() < 10 && akNewLoc && !akNewLoc.IsExplored() && akNewLoc && akNewLoc.HasRefType(LocStoryArtifactRoomReserveMarkerLocRef) && Game.GetPlayerLevel() >= RAS_MQLevelThreshold.GetValue() as Int)
    Int roll = Utility.RandomInt(1, 100)
    If(roll <= RAS_MQTriggerChance.GetValue() as Int)      
      Game.GetPlayer().SetValue(RAS_MinerStart, 0.0)
      
      RAS:NewGameManagerQuest:NewGameManagerQuestScript managerQuest = RAS_NewGameManagerQuest as RAS:NewGameManagerQuest:NewGameManagerQuestScript
      managerQuest.PreventMQ101FirstStage()
      managerQuest.HookMQ()

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