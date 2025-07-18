;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname Fragments:Scenes:SF__01000980 Extends Scene Hidden Const

;BEGIN FRAGMENT Fragment_End
Function Fragment_End()
;BEGIN AUTOCAST TYPE RAS_MQ101Script
RAS_MQ101Script kmyQuest = GetOwningQuest() as RAS_MQ101Script
;END AUTOCAST
;BEGIN CODE
kmyquest.MQ101EnablePlayerControls()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
