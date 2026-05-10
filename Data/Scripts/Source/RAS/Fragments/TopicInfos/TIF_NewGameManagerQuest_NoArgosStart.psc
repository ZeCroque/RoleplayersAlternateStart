;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname RAS:Fragments:TopicInfos:TIF_NewGameManagerQuest_NoArgosStart Extends TopicInfo Hidden Const

;BEGIN FRAGMENT Fragment_End
Function Fragment_End(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
RAS_ArgosStartUnavailableWarning.Show(RAS_MQTriggerChance.GetValue(), RAS_MQLevelThreshold.GetValue())
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Message Property RAS_ArgosStartUnavailableWarning Auto Const Mandatory

GlobalVariable Property RAS_MQTriggerChance Auto Const Mandatory

GlobalVariable Property RAS_MQLevelThreshold Auto Const Mandatory
