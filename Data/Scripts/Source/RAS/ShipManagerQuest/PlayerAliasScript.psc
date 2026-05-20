Scriptname RAS:ShipManagerQuest:PlayerAliasScript extends ReferenceAlias

Quest Property RAS_NewGameManagerQuest Mandatory Const Auto
Quest Property SQ_PlayerShip Mandatory Const Auto
Quest Property RAS_BrokenShipQuest Mandatory Const Auto
LocationRefType Property Ship_PilotSeat_RefType auto mandatory Const
ConditionForm Property RAS_HasPilotingRank3 Mandatory Const Auto
ConditionForm Property RAS_HasPilotingRank4 Mandatory Const Auto
Keyword Property ShipModuleClassA Mandatory Const Auto
Keyword Property ShipModuleClassB Mandatory Const Auto
Keyword Property ShipModuleClassC Mandatory Const Auto
Message Property RAS_BrokenHomeshipError Mandatory Const Auto

Event OnHomeShipSet(SpaceshipReference akShip, SpaceshipReference akPrevious)
    If(RAS_NewGameManagerQuest.GetStageDone(100))
        SpaceshipReference brokenShip = (RAS_BrokenShipQuest as RAS:BrokenShipQuest:BrokenShipQuestScript).ShipAlias.GetShipRef()
        RAS:ShipManagerQuest:ShipManagerQuestScript shipManagerScript = GetOwningQuest() as RAS:ShipManagerQuest:ShipManagerQuestScript
        SQ_PlayerShipScript sqPlayerShipQuest = SQ_PlayerShip as SQ_PlayerShipScript
        If(akShip != brokenShip)                  
            If(shipManagerScript.RAS_NoneShipReference && akShip != shipManagerScript.RAS_NoneShipReference)
                sqPlayerShipQuest.RemovePlayerShip(shipManagerScript.RAS_NoneShipReference)
                shipManagerScript.SetupPlayerShip(akShip)
            EndIf
        Else
            sqPlayerShipQuest.ResetHomeShip(akPrevious)
            RAS_BrokenHomeshipError.ShowAsHelpMessage("", 10, 0, 1)
        EndIf

        If(akPrevious == brokenShip)
            sqPlayerShipQuest.RemovePlayerShip(akPrevious)
            sqPlayerShipQuest.PlayerShip.ForceRefTo(shipManagerScript.RAS_NoneShipReference)
        EndIf
    EndIf
EndEvent

;In case the user uses StarfieldEngineFixes with DisableForcedHomeshipChangeOnPurchase, we force the bought ship as home ship if the player is pedestrian
Event OnPlayerBuyShip(SpaceshipReference akShip)
    If(RAS_NewGameManagerQuest.GetStageDone(100))
        RAS:ShipManagerQuest:ShipManagerQuestScript shipManagerScript = (GetOwningQuest() as RAS:ShipManagerQuest:ShipManagerQuestScript)
        If(shipManagerScript.RAS_NoneShipReference)
            (SQ_PlayerShip as SQ_PlayerShipScript).ResetHomeShip(akShip)
            akShip.Enable()
        EndIf
    EndIf
EndEvent

Event OnSit(ObjectReference akFurniture)
    ;whenever the player sits in the pilot seat, set this ship to be the current ship
    If akFurniture.HasRefType(Ship_PilotSeat_RefType)
        SpaceshipReference newShip = Game.GetPlayer().GetCurrentShipRef()
        Keyword reactorClass = newShip.GetReactorClassKeyword()
        RAS:ShipManagerQuest:ShipManagerQuestScript shipManagerScript = (GetOwningQuest() as RAS:ShipManagerQuest:ShipManagerQuestScript)
        If(shipManagerScript.RAS_NoneShipReference)
            If(reactorClass == ShipModuleClassA || (reactorClass == ShipModuleClassB && RAS_HasPilotingRank3.IsTrue()) || (reactorClass == ShipModuleClassC && RAS_HasPilotingRank4.IsTrue()))
                (SQ_PlayerShip as SQ_PlayerShipScript).ResetHomeShip(newShip)
            EndIf
        EndIf
    EndIf
EndEvent