Scriptname RAS_MQReplacerQuestScript extends Quest

LocationAlias Property ArtifactLocation Mandatory Const Auto
Quest Property StarbornTempleQuest Mandatory Const Auto
ReferenceAlias Property PlayerAlias Mandatory Const Auto

ObjectReference Property Artifact01REF Auto

Function HandleArtifact(ObjectReference akArtifactRef)
  Artifact01REF = akArtifactRef
  Self.RegisterForRemoteEvent(Artifact01REF, "OnSell")
EndFunction

Event ObjectReference.OnSell(ObjectReference akSender, Actor akSeller)
  Self.UnregisterForRemoteEvent(Artifact01REF, "OnSell")
  (StarbornTempleQuest as StarbornTempleQuestScript).MQ00_ArtifactsHolder.AddRef(Artifact01REF) ;make it a quest item
  Artifact01REF = None ;We disposed of artifact the right way, we no longer handle it
  SetStage(30)
  PlayerAlias.Clear()
EndEvent