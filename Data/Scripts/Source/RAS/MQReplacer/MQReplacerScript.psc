Scriptname RAS:MQReplacer:MQReplacerScript extends Quest

LocationAlias Property ArtifactLocation Mandatory Const Auto
ReferenceAlias Property PlayerAlias Mandatory Const Auto
ReferenceAlias Property MauriceLyonAlias Mandatory Const Auto
FormList Property RAS_ExcludedArtifactLocationsList Mandatory Const Auto
Quest Property RAS_NewGameManagerQuest Mandatory Const Auto
ActorValue Property RAS_MinerStart Mandatory Const Auto

ObjectReference Property Artifact01REF Auto Hidden
ObjectReference Property Artifact01REFCopy Auto Hidden

Function InitArtifactExclusionList()
  RAS_ExcludedArtifactLocationsList.AddForm(Game.GetFormFromFile(0x3AA68, "poi_variations_shuffle.esm"))
  RAS_ExcludedArtifactLocationsList.AddForm(Game.GetFormFromFile(0x671A2, "poi_variations_shuffle.esm"))
EndFunction

Event OnQuestInit()
  InitArtifactExclusionList()
EndEvent

Function StartMQReplacer(Location akLocation)
  Game.GetPlayer().SetValue(RAS_MinerStart, 0.0)

  RAS:NewGameManagerQuest:NewGameManagerQuestScript managerQuest = RAS_NewGameManagerQuest as RAS:NewGameManagerQuest:NewGameManagerQuestScript
  managerQuest.PreventMQ101FirstStage()
  managerQuest.HookMQ()

  ArtifactLocation.ForceLocationTo(akLocation)
  ArtifactLocation.RefillDependentAliases()
  SetStage(10)  
EndFunction

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