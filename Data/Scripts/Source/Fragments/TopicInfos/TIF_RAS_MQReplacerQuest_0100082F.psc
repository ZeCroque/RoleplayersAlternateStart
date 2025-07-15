;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname Fragments:TopicInfos:TIF_RAS_MQReplacerQuest_0100082F Extends TopicInfo Hidden Const

;BEGIN FRAGMENT Fragment_End
Function Fragment_End(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN AUTOCAST TYPE RAS_MQReplacerQuestScript
RAS_MQReplacerQuestScript kmyQuest = GetOwningQuest() as RAS_MQReplacerQuestScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.MauriceLyonAlias.ForceRefTo(UC_NH_MauriceLyon)
kmyQuest.SetObjectiveCompleted(19)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ObjectReference Property UC_NH_MauriceLyon Auto Const
