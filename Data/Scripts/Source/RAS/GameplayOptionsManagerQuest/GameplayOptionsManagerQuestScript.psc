Scriptname RAS:GameplayOptionsManagerQuest:GameplayOptionsManagerQuestScript extends Quest

GameplayOption Property RAS_RemovePlaceholderShip Mandatory Const Auto
Quest Property SQ_PlayerShip Mandatory Const Auto
Message Property RAS_PlaceholderDebugScriptSuccess Mandatory Const Auto
Message Property RAS_PlaceholderDebugScriptError Mandatory Const Auto
Quest Property RAS_ShipManagerQuest Mandatory Const Auto

Event OnQuestInit()
    RegisterForGameplayOptionChangedEvent()
EndEvent

Event OnGameplayOptionChanged(GameplayOption[] aChangedOptions)
    If(aChangedOptions.Find(RAS_RemovePlaceholderShip) != -1)
        SQ_PlayerShipScript playerShipQuest = SQ_PlayerShip as SQ_PlayerShipScript
        RAS:ShipManagerQuest:ShipManagerQuestScript rasShipScript = RAS_ShipManagerQuest as RAS:ShipManagerQuest:ShipManagerQuestScript
        If(playerShipQuest.PlayerShip.GetShipReference() == rasShipScript.RAS_NoneShipReference)
            Int i = 0
            While(i < playerShipQuest.PlayerShips.GetCount())
                SpaceshipReference ship = playerShipQuest.PlayerShips.GetAt(i) as SpaceshipReference
                If(ship != rasShipScript.RAS_NoneShipReference)
                    playerShipQuest.ResetHomeShip(ship)
                    RAS_PlaceholderDebugScriptSuccess.Show()
                    Return
                EndIf
                i += 1
            EndWhile
        EndIf
        RAS_PlaceholderDebugScriptError.Show()
    EndIf
EndEvent