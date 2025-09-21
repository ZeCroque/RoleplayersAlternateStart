;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname RAS:Fragments:Scenes:SF_MQ101_034c Extends Scene Hidden Const

;BEGIN FRAGMENT Fragment_End
Function Fragment_End()
;BEGIN AUTOCAST TYPE RAS:MQ101:MQ101Script
RAS:MQ101:MQ101Script kmyQuest = GetOwningQuest() as RAS:MQ101:MQ101Script
;END AUTOCAST
;BEGIN CODE
kmyquest.MQ101EnablePlayerControls()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
