;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname RAS:Fragments:TopicInfos:TIF_MQ101_SarahGivesArtifact Extends TopicInfo Hidden Const

;BEGIN FRAGMENT Fragment_End
Function Fragment_End(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN AUTOCAST TYPE RAS:MQ101:MQ101Script
RAS:MQ101:MQ101Script kmyQuest = GetOwningQuest() as RAS:MQ101:MQ101Script
;END AUTOCAST
;BEGIN CODE
Game.GetPlayer().AddItem(kmyQuest.Artifact01REF)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
