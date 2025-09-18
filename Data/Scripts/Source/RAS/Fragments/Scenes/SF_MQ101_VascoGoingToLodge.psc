;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname RAS:Fragments:Scenes:SF_MQ101_VascoGoingToLodge Extends Scene Hidden Const

;BEGIN FRAGMENT Fragment_Phase_01_End
Function Fragment_Phase_01_End()
;BEGIN AUTOCAST TYPE RAS_MQ101Script
RAS_MQ101Script kmyQuest = GetOwningQuest() as RAS_MQ101Script
;END AUTOCAST
;BEGIN CODE
kmyQuest.NewAtlantisToLodgeDoorREF.Unlock()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
