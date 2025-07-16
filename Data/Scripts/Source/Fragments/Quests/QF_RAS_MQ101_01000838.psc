;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname Fragments:Quests:QF_RAS_MQ101_01000838 Extends Quest Hidden Const

;BEGIN FRAGMENT Fragment_Stage_0005_Item_00
Function Fragment_Stage_0005_Item_00()
;BEGIN AUTOCAST TYPE RAS_MQ101Script
Quest __temp = self as Quest
RAS_MQ101Script kmyQuest = __temp as RAS_MQ101Script
;END AUTOCAST
;BEGIN CODE
Game.GetPlayer().AddItem(kmyQuest.ConstellationInvite.GetReference())
SetObjectiveDisplayed(5)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0010_Item_00
Function Fragment_Stage_0010_Item_00()
;BEGIN AUTOCAST TYPE RAS_MQ101Script
Quest __temp = self as Quest
RAS_MQ101Script kmyQuest = __temp as RAS_MQ101Script
;END AUTOCAST
;BEGIN CODE
kmyQuest.ConstellationInvite.Clear()
kmyQuest.PlayerAlias.Clear()

SetObjectiveCompleted(5)
SetObjectiveDisplayed(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0015_Item_00
Function Fragment_Stage_0015_Item_00()
;BEGIN CODE
SetObjectiveDisplayed(10)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
