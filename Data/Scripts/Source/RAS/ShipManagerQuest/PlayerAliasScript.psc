Scriptname RAS:ShipManagerQuest:PlayerAliasScript extends ReferenceAlias

Quest Property RAS_NewGameManagerQuest Mandatory Const Auto
Quest Property SQ_PlayerShip Mandatory Const Auto
LocationRefType Property Ship_PilotSeat_RefType auto mandatory Const
ConditionForm Property RAS_HasPilotingRank3 Mandatory Const Auto
ConditionForm Property RAS_HasPilotingRank4 Mandatory Const Auto
Keyword Property ShipModuleClassA Mandatory Const Auto
Keyword Property ShipModuleClassB Mandatory Const Auto
Keyword Property ShipModuleClassC Mandatory Const Auto

Event OnHomeShipSet(SpaceshipReference akShip, SpaceshipReference akPrevious)
    If(RAS_NewGameManagerQuest.GetStageDone(100))
        RAS:ShipManagerQuest:ShipManagerQuestScript shipManagerScript = (GetOwningQuest() as RAS:ShipManagerQuest:ShipManagerQuestScript)
        If(shipManagerScript.RAS_NoneShipReference)
            Game.RemovePlayerOwnedShip(shipManagerScript.RAS_NoneShipReference)
            shipManagerScript.SetupPlayerShip(akShip)
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