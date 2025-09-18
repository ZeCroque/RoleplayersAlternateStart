;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname RAS:Fragments:Quests:QF_MQReplacer Extends Quest Hidden Const

;BEGIN FRAGMENT Fragment_Stage_0010_Item_00
Function Fragment_Stage_0010_Item_00()
;BEGIN CODE
ObjectReference ArtifactActivator01REF = (StarbornTempleQuest as StarbornTempleQuestScript).PlaceEmbeddedArtifact(0, Artifact.GetRef())
Artifact.ForceRefTo(ArtifactActivator01REF)
ArtifactActivator01REF.EnableNoWait()
ArtifactOpenCaveMarker.GetRef().EnableNoWait()
ArtifactClosedCaveMarker.GetRef().DisableNoWait()
SetObjectiveDisplayed(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0020_Item_00
Function Fragment_Stage_0020_Item_00()
;BEGIN CODE
;give player the appropriate artifact
ObjectReference Artifact01REF = (StarbornTempleQuest as StarbornTempleQuestScript).PlaceArtifact(0, MQHoldingCellCenterMarker)
ObjectReference ArtifactCopy = MQHoldingCellCenterMarker.PlaceAtMe(RAS_Artifact_ETA)
Game.GetPlayer().additem(ArtifactCopy)
(RAS_MQReplacerQuest as RAS_MQReplacerQuestScript).HandleArtifact(Artifact01REF, ArtifactCopy)
(PlayerAlias as RAS_MQReplacerPlayerAliasScript).HandleArtifact(ArtifactCopy)

;Set player as having acquired the Artifact
(StarbornTempleQuest as StarbornTempleQuestScript).SetPlayerAcquiredArtifact(0)

SetObjectiveCompleted(10)
SetObjectiveDisplayed(19)
SetObjectiveDisplayed(20)
SetObjectiveDisplayed(25)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0030_Item_00
Function Fragment_Stage_0030_Item_00()
;BEGIN CODE
SetObjectiveCompleted(25)
(RAS_MQ101 as RAS_MQ101Script).Artifact01REF = (RAS_MQReplacerQuest as RAS_MQReplacerQuestScript).Artifact01REF
RAS_MQ101.SetStage(0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0040_Item_00
Function Fragment_Stage_0040_Item_00()
;BEGIN CODE
RAS_MQReplacerQuestScript MQReplacerQuestScript = (RAS_MQReplacerQuest as RAS_MQReplacerQuestScript)
ObjectReference PlayerREF = Game.GetPlayer()

(RAS_MQ101 as RAS_MQ101Script).Artifact01REF = MQReplacerQuestScript.Artifact01REF
MQReplacerQuestScript.PlayerAlias.Clear()
PlayerREF.RemoveItem(MQReplacerQuestScript.Artifact01REFCopy, abSilent=True)
PlayerREF.AddItem(MQReplacerQuestScript.Artifact01REF, abSilent=True)

SetObjectiveCompleted(20)
RAS_MQ101.SetStage(15)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property Artifact Mandatory Const Auto

ReferenceAlias Property ArtifactClosedCaveMarker Mandatory Const Auto

ReferenceAlias Property ArtifactOpenCaveMarker Mandatory Const Auto

Quest Property StarbornTempleQuest Mandatory Const Auto

ObjectReference Property MQHoldingCellCenterMarker Auto Const Mandatory

Quest Property RAS_MQReplacerQuest Auto Const Mandatory

ReferenceAlias Property PlayerAlias Mandatory Const Auto

MiscObject Property RAS_Artifact_ETA Auto Const Mandatory

Quest Property RAS_MQ101 Auto Const Mandatory
