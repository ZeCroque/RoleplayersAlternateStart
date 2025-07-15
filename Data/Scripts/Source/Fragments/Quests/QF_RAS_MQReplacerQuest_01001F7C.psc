;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname Fragments:Quests:QF_RAS_MQReplacerQuest_01001F7C Extends Quest Hidden Const

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
ObjectReference Artifact01REF = MQHoldingCellCenterMarker.PlaceAtMe((StarbornTempleQuest as StarbornTempleQuestScript).currentPlaythroughArtifacts[0].Artifacts, abInitiallyDisabled=False, abDeleteWhenAble=False)
Game.GetPlayer().additem(Artifact01REF)
(RAS_MQReplacerQuest as RAS_MQReplacerQuestScript).HandleArtifact(Artifact01REF)
(PlayerAlias as RAS_MQReplacerPlayerAliasScript).HandleArtifact(Artifact01REF)

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
