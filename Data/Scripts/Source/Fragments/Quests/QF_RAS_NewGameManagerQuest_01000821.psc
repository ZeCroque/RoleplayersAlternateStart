;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname Fragments:Quests:QF_RAS_NewGameManagerQuest_01000821 Extends Quest Hidden Const

;BEGIN FRAGMENT Fragment_Stage_0000_Item_00
Function Fragment_Stage_0000_Item_00()
;BEGIN CODE
If(Game.GetPlayer().GetValue(PlayerUnityTimesEntered) == 0)
    SetObjectiveDisplayed(10)
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ActorValue Property PlayerUnityTimesEntered Auto Const Mandatory
