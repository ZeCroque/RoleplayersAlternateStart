;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname RAS:Fragments:TopicInfos:TIF_NewGameManagerQuest_ArgosApply Extends TopicInfo Hidden Const

;BEGIN FRAGMENT Fragment_End
Function Fragment_End(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN AUTOCAST TYPE RAS:NewGameManagerQuest:NewGameManagerQuestScript
RAS:NewGameManagerQuest:NewGameManagerQuestScript kmyQuest = GetOwningQuest() as RAS:NewGameManagerQuest:NewGameManagerQuestScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.LockPlayer()	
Game.GetPlayer().RemoveAllItems(kmyQuest.RAS_StartingStuffContainer)
Game.GetPlayer().MoveTo(kmyQuest.RAS_GameStartCellMarkerREF)
kmyQuest.InitVanillaStart()
kmyQuest.HookVanillaMQ101()

LC001VecteraLiftDoor.Unlock()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ObjectReference Property LC001VecteraLiftDoor Auto Const Mandatory
