Scriptname RAS:MQReplacer:MQReplacerScript extends Quest

LocationAlias Property ArtifactLocation Mandatory Const Auto
ReferenceAlias Property PlayerAlias Mandatory Const Auto
ReferenceAlias Property MauriceLyonAlias Mandatory Const Auto

ObjectReference Property Artifact01REF Auto Hidden
ObjectReference Property Artifact01REFCopy Auto Hidden

Function HandleArtifact(ObjectReference akArtifactRef, ObjectReference akArtifactCopy)
  Artifact01REF = akArtifactRef
  Artifact01REFCopy = akArtifactCopy
  Self.RegisterForRemoteEvent(akArtifactCopy, "OnSell")
EndFunction

Event ObjectReference.OnSell(ObjectReference akSender, Actor akSeller)
  Self.UnregisterForRemoteEvent(Artifact01REF, "OnSell")
  Artifact01REFCopy.Drop(True)
  Artifact01REFCopy = None
  SetStage(30)
  PlayerAlias.Clear()
EndEvent