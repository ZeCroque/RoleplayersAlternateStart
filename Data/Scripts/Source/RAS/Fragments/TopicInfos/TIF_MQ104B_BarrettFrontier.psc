;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname RAS:Fragments:TopicInfos:TIF_MQ104B_BarrettFrontier Extends TopicInfo Hidden Const

;BEGIN FRAGMENT Fragment_End
Function Fragment_End(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN AUTOCAST TYPE RAS_MQ104BScript
RAS:MQ104B:MQ104BScript kmyQuest = GetOwningQuest() as RAS:MQ104B:MQ104BScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.SetStage(1000)
RAS_FrontierPickUpQuest.SetStage(0)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property RAS_FrontierPickUpQuest Auto Const Mandatory
