;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname RAS:Fragments:Quests:QF_BrokenShipQuest Extends Quest Hidden Const

;BEGIN FRAGMENT Fragment_Stage_0000_Item_00
Function Fragment_Stage_0000_Item_00()
;BEGIN CODE
SetObjectiveDisplayed(0)
SetObjectiveDisplayed(1)
(PlayerAlias as RAS:BrokenShipQuest:PlayerAliasScript).StartTrackingResources()
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

;BEGIN FRAGMENT Fragment_Stage_0001_Item_00
Function Fragment_Stage_0001_Item_00()
;BEGIN CODE
SetObjectiveDisplayed(6)
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
ShipPilotChair.GetReference().BlockActivation(False, False)

SQ_PlayerShipScript shipQuest = SQ_PlayerShip as SQ_PlayerShipScript
If(shipQuest.PlayerShip.GetShipReference() == (RAS_ShipManagerQuest as RAS:ShipManagerQuest:ShipManagerQuestScript).RAS_NoneShipReference)
    SpaceshipReference brokenShip = kmyQuest.ShipAlias.GetShipReference()
    shipQuest.ResetHomeShip(brokenShip)

    If(GetStageDone(1))
        ObjectReference shipMarker = ShipServicesTechAlias.GetRef().GetLinkedRef(LinkShipLandingMarker01)
    
        ObjectReference[] linkedShips = shipMarker.GetRefsLinkedToMe(CurrentInteractionLinkedRefKeyword)
        If(linkedShips.Length)
            linkedShips[0].Disable()
        EndIf

        brokenShip.MoveTo(shipMarker)
        brokenShip.SetLinkedRef(shipMarker, CurrentInteractionLinkedRefKeyword)
        brokenShip.EnableWithLanding()
    Endif
Else
    shipQuest.AddPlayerOwnedShip(kmyQuest.ShipAlias.GetShipReference())
EndIf

SetObjectiveCompleted(2)
SetObjectiveCompleted(5)
SetObjectiveCompleted(6)
Stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property PlayerAlias Auto Const Mandatory

ReferenceAlias Property ShipPilotChair Auto Const Mandatory

Quest Property SQ_PlayerShip Auto Const Mandatory

Quest Property RAS_ShipManagerQuest Auto Const Mandatory

ReferenceAlias Property ShipServicesTechAlias Auto Const Mandatory

Keyword Property LinkShipLandingMarker01 Auto Const Mandatory

Keyword Property CurrentInteractionLinkedRefKeyword Auto Const Mandatory
