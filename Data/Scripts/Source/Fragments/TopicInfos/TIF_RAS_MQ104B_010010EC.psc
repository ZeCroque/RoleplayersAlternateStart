;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname Fragments:TopicInfos:TIF_RAS_MQ104B_010010EC Extends TopicInfo Hidden Const

;BEGIN FRAGMENT Fragment_End
Function Fragment_End(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN AUTOCAST TYPE RAS_MQ104BScript
RAS_MQ104BScript kmyQuest = GetOwningQuest() as RAS_MQ104BScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.SetStage(1000)
RAS_FrontierPickUpQuest.SetStage(0)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property RAS_FrontierPickUpQuest Auto Const Mandatory
