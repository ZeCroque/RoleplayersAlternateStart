Scriptname RAS:ShipManagerQuest:PlayerAliasScript extends ReferenceAlias

Quest Property RAS_NewGameManagerQuest Mandatory Const Auto

Event OnHomeShipSet(SpaceshipReference akShip, SpaceshipReference akPrevious)
    If(RAS_NewGameManagerQuest.GetStageDone(100))
        RAS:ShipManagerQuest:ShipManagerQuestScript shipManagerScript = (GetOwningQuest() as RAS:ShipManagerQuest:ShipManagerQuestScript)
        If(shipManagerScript.RAS_NoneShipReference)
            Game.RemovePlayerOwnedShip(shipManagerScript.RAS_NoneShipReference)
            shipManagerScript.SetupPlayerShip(akShip)
        EndIf
    EndIf
EndEvent