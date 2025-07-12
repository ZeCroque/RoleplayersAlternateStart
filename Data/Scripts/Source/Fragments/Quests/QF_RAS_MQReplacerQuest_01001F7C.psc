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

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property Artifact Mandatory Const Auto

ReferenceAlias Property ArtifactClosedCaveMarker Mandatory Const Auto

ReferenceAlias Property ArtifactOpenCaveMarker Mandatory Const Auto

Quest Property StarbornTempleQuest Mandatory Const Auto
