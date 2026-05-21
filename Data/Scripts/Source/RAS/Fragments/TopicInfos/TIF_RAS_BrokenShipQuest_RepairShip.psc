;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname RAS:Fragments:TopicInfos:TIF_RAS_BrokenShipQuest_RepairShip Extends TopicInfo Hidden Const

;BEGIN FRAGMENT Fragment_End
Function Fragment_End(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetStage(10)
Game.RemovePlayerCaps(RAS_BrokenShipQuest_ShiptechRepairCost.GetValueInt())
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property RAS_BrokenShipQuest_ShiptechRepairCost Auto Const Mandatory
