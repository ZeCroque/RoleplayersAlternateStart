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

;BEGIN FRAGMENT Fragment_Stage_0010_Item_00
Function Fragment_Stage_0010_Item_00()
;BEGIN CODE
SetObjectiveDisplayed(11)
SetObjectiveDisplayed(12)
SetObjectiveDisplayed(13)
SetObjectiveDisplayed(14)
SetObjectiveDisplayed(15)
SetObjectiveDisplayed(16)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0011_Item_00
Function Fragment_Stage_0011_Item_00()
;BEGIN CODE
SetObjectiveDisplayed(20)
RAS_StartNotReadyTriggerREF.Disable()
RAS_StartNotReadyCollisionVolume.Disable()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ActorValue Property PlayerUnityTimesEntered Auto Const Mandatory

ObjectReference Property RAS_StartNotReadyTriggerREF Auto Const Mandatory

ObjectReference Property RAS_StartNotReadyCollisionVolume Auto Const Mandatory
