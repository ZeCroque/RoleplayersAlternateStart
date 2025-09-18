;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname RAS:Fragments:TopicInfos:TIF_MQReplacer_ShipTech Extends TopicInfo Hidden Const

;BEGIN FRAGMENT Fragment_End
Function Fragment_End(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN AUTOCAST TYPE RAS_MQReplacerQuestScript
RAS:MQReplacer:MQReplacerScript kmyQuest = GetOwningQuest() as RAS:MQReplacer:MQReplacerScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.MauriceLyonAlias.ForceRefTo(UC_NH_MauriceLyon)
kmyQuest.SetObjectiveCompleted(19)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ObjectReference Property UC_NH_MauriceLyon Auto Const
