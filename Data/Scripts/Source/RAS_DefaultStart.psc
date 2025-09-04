Scriptname RAS_DefaultStart extends MiscObject

ObjectReference Property DynamicTerminal Mandatory Const Auto

Location Property TargetLocation  Auto
Quest Property RAS_NewGameManagerQuest Mandatory Const Auto
Message Property RAS_ImpossibleToStartMessage Mandatory Const Auto
ObjectReference Property RAS_ShipServicesActorREF Mandatory Const Auto
Keyword Property CurrentInteractionLinkedRefKeyword Mandatory Const Auto
Keyword Property LinkShipLandingMarker01 Mandatory Const Auto
Keyword Property SpaceshipDockDoor Mandatory Const Auto
Keyword Property SpaceshipLinkedExterior Mandatory Const Auto

Event OnInit()
    RegisterForCustomEvent(DynamicTerminal as RAS_DynamicEntriesTerminalScript, "SelectedFragmentTriggered")
EndEvent

Event RAS_DynamicEntriesTerminalScript.SelectedFragmentTriggered(RAS_DynamicEntriesTerminalScript akSender, var[] kArgs)
    If(kArgs[0] as Form == Self)
        RAS_NewGameManagerQuestScript newGameManagerQuestScript = RAS_NewGameManagerQuest as RAS_NewGameManagerQuestScript
        newGameManagerQuestScript.StartingLocationAlias.ForceLocationTo(TargetLocation)
        Location[] parentLocations = TargetLocation.GetParentLocations()
        If(parentLocations.Length)
            newGameManagerQuestScript.StartingLocationParentAlias.ForceLocationTo(parentLocations[0])
        EndIf
        newGameManagerQuestScript.StartingLocationMapMarkerAlias.RefillAlias()
        newGameManagerQuestScript.StartingLocationShipMarkerAlias.RefillAlias()
        newGameManagerQuestScript.StartingLocationParentMapMarkerAlias.RefillAlias()

        SpaceshipReference CurrentShip = (RAS_ShipServicesActorREF as RAS_ShipVendorScript).currentShip
        ObjectReference startMarker = newGameManagerQuestScript.StartingLocationMapMarkerAlias.GetReference() 
        Debug.Trace("mapmarker" + startMarker)

        ;Sets up spaceship markers if applicable
        newGameManagerQuestScript.StartingLocationDockingPortDoorAlias.RefillAlias()
        ObjectReference shipDockingDoor = newGameManagerQuestScript.StartingLocationDockingPortDoorAlias.GetReference()
        ObjectReference spaceMarker = newGameManagerQuestScript.StartingLocationParentMapMarkerAlias.GetReference()
        ObjectReference[] dockingPorts = None
        ObjectReference validDockingPort = None
        Debug.Trace("dockingdoor" + shipDockingDoor)
        Debug.Trace("spaceMarker" + spaceMarker)
        If(shipDockingDoor && spaceMarker)
            Cell shipExteriorCell = shipDockingDoor.GetParentCell().GetParentRef().GetLinkedCell(SpaceshipLinkedExterior)
            Debug.Trace("cell" + shipExteriorCell)

            dockingPorts = shipDockingDoor.GetRefsLinkedToMe(SpaceshipDockDoor)
            Int i = 0
            While(i < dockingPorts.Length)
                If(dockingPorts[i].GetParentCell() == shipExteriorCell)
                    validDockingPort = dockingPorts[i]
                    i = dockingPorts.Length ; break
                EndIf
                Debug.Trace(dockingPorts[i])
                i += 1
            EndWhile
        EndIf
        Debug.Trace(validDockingPort)

        If(validDockingPort)
            ;in spaceship
            CurrentShip.MoveTo(spaceMarker)
            CurrentShip.InstantDock(validDockingPort)
            CurrentShip.Enable()
            Game.GetPlayer().MoveTo(CurrentShip)
        Else
            ;on planet (or spaceship setup unexpected)
            If(startMarker)
                ;search for ship tech
                newGameManagerQuestScript.StartingLocationShipTechAlias.RefillAlias()
                ObjectReference shipTech = newGameManagerQuestScript.StartingLocationShipTechAlias.GetReference()
                Debug.Trace("tecch" + shipTech)

                If(shipTech)
                    ;has ship tech (settlement), find ship marker with it and move player to ship
                    ObjectReference shipMarker = shipTech.GetLinkedRef(LinkShipLandingMarker01)
                    Debug.Trace("shipMarker" + shipMarker)
                    CurrentShip.MoveTo(shipMarker)
                    CurrentShip.SetLinkedRef(shipMarker, CurrentInteractionLinkedRefKeyword)
                    CurrentShip.Enable()
                    Game.GetPlayer().MoveTo(CurrentShip)
                Else
                    ObjectReference shipMarker = newGameManagerQuestScript.StartingLocationShipMarkerAlias.GetReference()
                    If(shipMarker)
                        ;No ship tech but ship marker (POI) move to ship marker (hoping it's the right one)
                        Debug.Trace("marker" + shipMarker)
                        CurrentShip.MoveTo(shipMarker)
                        CurrentShip.SetLinkedRef(shipMarker, CurrentInteractionLinkedRefKeyword)
                        CurrentShip.Enable()
                        Game.GetPlayer().MoveTo(CurrentShip)
                    Else
                        Game.GetPlayer().MoveTo(startMarker)
                    EndIf
                EndIf
            Else
                ;Nothing appropriate to move, cancelling
                RAS_ImpossibleToStartMessage.Show()
            EndIf
        EndIf
    Endif
EndEvent
