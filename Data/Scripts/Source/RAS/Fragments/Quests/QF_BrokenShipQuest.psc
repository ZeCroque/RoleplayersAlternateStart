;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname RAS:Fragments:Quests:QF_BrokenShipQuest Extends Quest Hidden Const

;BEGIN FRAGMENT Fragment_Stage_0000_Item_00
Function Fragment_Stage_0000_Item_00()
;BEGIN CODE
SetObjectiveDisplayed(0)
SetObjectiveDisplayed(1)
(Alias_PlayerAlias as RAS:BrokenShipQuest:PlayerAliasScript).StartTrackingResources()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0000_Item_01
Function Fragment_Stage_0000_Item_01()
;BEGIN CODE
SetObjectiveDisplayed(2)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0005_Item_00
Function Fragment_Stage_0005_Item_00()
;BEGIN CODE
SetObjectiveDisplayed(5)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0010_Item_00
Function Fragment_Stage_0010_Item_00()
;BEGIN AUTOCAST TYPE RAS:BrokenShipQuest:BrokenShipQuestScript
Quest __temp = self as Quest
RAS:BrokenShipQuest:BrokenShipQuestScript kmyQuest = __temp as RAS:BrokenShipQuest:BrokenShipQuestScript
;END AUTOCAST
;BEGIN CODE
Alias_ShipPilotChair.GetReference().BlockActivation(False, False)

SQ_PlayerShipScript shipQuest = SQ_PlayerShip as SQ_PlayerShipScript
If(shipQuest.PlayerShip.GetShipReference() == (RAS_ShipManagerQuest as RAS:ShipManagerQuest:ShipManagerQuestScript).RAS_NoneShipReference)
    shipQuest.ResetHomeShip(kmyQuest.ShipAlias.GetShipReference())
EndIf

SetObjectiveCompleted(5)
Stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property Alias_PlayerAlias Auto Const Mandatory

ReferenceAlias Property Alias_ShipPilotChair Auto Const Mandatory

Quest Property SQ_PlayerShip Auto Const Mandatory

Quest Property RAS_ShipManagerQuest Auto Const Mandatory
