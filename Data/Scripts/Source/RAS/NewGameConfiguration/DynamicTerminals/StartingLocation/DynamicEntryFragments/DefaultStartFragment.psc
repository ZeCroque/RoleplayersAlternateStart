Scriptname RAS:NewGameConfiguration:DynamicTerminals:StartingLocation:DynamicEntryFragments:DefaultStartFragment extends MiscObject

ObjectReference Property DynamicTerminal Mandatory Const Auto

Location Property TargetLocation  Auto
Quest Property RAS_NewGameManagerQuest Mandatory Const Auto
Quest Property RAS_ShipManagerQuest Mandatory Const Auto
Message Property RAS_ImpossibleToStartMessage Mandatory Const Auto
ObjectReference Property RAS_ShipServicesActorREF Mandatory Const Auto
Keyword Property CurrentInteractionLinkedRefKeyword Mandatory Const Auto
Keyword Property LinkShipLandingMarker01 Mandatory Const Auto
Keyword Property SpaceshipDockDoor Mandatory Const Auto
Keyword Property SpaceshipLinkedExterior Mandatory Const Auto
Keyword Property DynamicallyLinkedDoorTeleportMarkerKeyword Mandatory Const Auto
Terminal Property RAS_StartingMapMarkerTerminal Mandatory Const Auto
TerminalMenu Property RAS_StartingMapMarkerTerminalMenu Mandatory Const Auto
MiscObject Property RAS_DynamicEntry_MapMarker_Ship Mandatory Const Auto
MiscObject Property RAS_DynamicEntry_MapMarker_Viewport Mandatory Const Auto

ObjectReference startingMapMarkerTerminal 
ObjectReference shipMarker

Event OnInit()
    RegisterForCustomEvent(DynamicTerminal as RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript, "SelectedFragmentTriggered")
EndEvent

Event RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript.SelectedFragmentTriggered(RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript akSender, var[] kArgs)
    If(kArgs[0] as Form == Self)
        RAS:NewGameManagerQuest:NewGameManagerQuestScript newGameManagerQuestScript = RAS_NewGameManagerQuest as RAS:NewGameManagerQuest:NewGameManagerQuestScript
        RAS:NewGameConfiguration:ShipVendorScript myShipVendorScript = RAS_ShipServicesActorREF as RAS:NewGameConfiguration:ShipVendorScript
        SpaceshipReference CurrentShip = (RAS_ShipManagerQuest as RAS:ShipManagerQuest:ShipManagerQuestScript).CurrentShip

        ;Fill aliases
        newGameManagerQuestScript.StartingLocationAlias.ForceLocationTo(TargetLocation)
        Location[] parentLocations = TargetLocation.GetParentLocations()
        If(parentLocations.Length)
            newGameManagerQuestScript.StartingLocationParentAlias.ForceLocationTo(parentLocations[0])
        EndIf
        newGameManagerQuestScript.StartingLocationMapMarkersCollectionAlias.RefillAlias()
        newGameManagerQuestScript.StartingLocationShipMarkerAlias.RefillAlias()
        newGameManagerQuestScript.StartingLocationParentMapMarkerAlias.RefillAlias()

        ;Sets up spaceship markers if applicable
        newGameManagerQuestScript.StartingLocationDockingPortDoorAlias.RefillAlias()
        ObjectReference shipDockingDoor = newGameManagerQuestScript.StartingLocationDockingPortDoorAlias.GetReference()
        ObjectReference spaceMarker = newGameManagerQuestScript.StartingLocationParentMapMarkerAlias.GetReference()
        
        ;Find spaceship docking port
        ObjectReference validDockingPort = None
        If(shipDockingDoor && spaceMarker)
            Cell shipExteriorCell = shipDockingDoor.GetParentCell().GetParentRef().GetLinkedCell(SpaceshipLinkedExterior)

            ObjectReference[] dockingPorts = shipDockingDoor.GetRefsLinkedToMe(SpaceshipDockDoor)
            Int i = 0
            While(i < dockingPorts.Length)
                If(dockingPorts[i].GetParentCell() == shipExteriorCell)
                    validDockingPort = dockingPorts[i]
                    i = dockingPorts.Length ; break
                EndIf
                i += 1
            EndWhile
        EndIf

        If(validDockingPort)
            ;in spaceship
            If(myShipVendorScript.NoShipSelected)
                Game.GetPlayer().MoveTo(shipDockingDoor.GetLinkedRef(DynamicallyLinkedDoorTeleportMarkerKeyword))
            Else
                CurrentShip.MoveTo(spaceMarker)
                CurrentShip.InstantDock(validDockingPort)
                CurrentShip.Enable()
                Game.GetPlayer().MoveTo(CurrentShip)
            EndIf
        Else
            ;on planet (or spaceship setup unexpected)
            If(newGameManagerQuestScript.StartingLocationMapMarkersCollectionAlias.GetCount())
                ;search for ship 
                newGameManagerQuestScript.StartingLocationShipTechAlias.RefillAlias()
                ObjectReference shipTech = newGameManagerQuestScript.StartingLocationShipTechAlias.GetReference()

                If(shipTech)
                    ;has ship tech (settlement), find ship marker linked to it
                    shipMarker = shipTech.GetLinkedRef(LinkShipLandingMarker01)
                    If(!myShipVendorScript.NoShipSelected)
                        CurrentShip.MoveTo(shipMarker)
                        CurrentShip.SetLinkedRef(shipMarker, CurrentInteractionLinkedRefKeyword)
                        CurrentShip.Enable()
                        If(newGameManagerQuestScript.StartingLocationMapMarkersCollectionAlias.GetCount() == 1)
                            Game.GetPlayer().MoveTo(shipMarker)
                            Game.GetPlayer().MoveTo(CurrentShip)
                            Return
                        EndIf
                    ElseIf(newGameManagerQuestScript.StartingLocationMapMarkersCollectionAlias.GetCount() == 1)
                        Game.GetPlayer().MoveTo(shipMarker)

                        ;Sometimes the ship tech could lead to a secondary ship marker that can be occupied (eg: RedMile)
                        ObjectReference[] linkedShips = shipMarker.GetRefsLinkedToMe(CurrentInteractionLinkedRefKeyword)
                        If(linkedShips.Length)
                            linkedShips[0].Disable()
                        EndIf
                        Return
                    EndIf

                    SelectMapMarker()
                Else
                    shipMarker = newGameManagerQuestScript.StartingLocationShipMarkerAlias.GetReference()
                    If(shipMarker)
                        ;No ship tech but ship marker (POI)(undefined behavior if more than one ship landing marker)
                        If(myShipVendorScript.NoShipSelected)
                            Game.GetPlayer().MoveTo(shipMarker)
                        Else
                            CurrentShip.MoveTo(shipMarker)
                            CurrentShip.SetLinkedRef(shipMarker, CurrentInteractionLinkedRefKeyword)
                            CurrentShip.Enable()
                            Game.GetPlayer().MoveTo(CurrentShip)
                        EndIf
                    Else
                        ;Fallback to the only known ref we have
                        Game.GetPlayer().MoveTo(newGameManagerQuestScript.StartingLocationMapMarkersCollectionAlias.GetAt(0))
                    EndIf
                EndIf
            Else
                ;Nothing appropriate to move, cancelling
                RAS_ImpossibleToStartMessage.Show()
            EndIf
        EndIf
    Endif
EndEvent

Function SelectMapMarker()
    RAS:NewGameManagerQuest:NewGameManagerQuestScript newGameManagerQuestScript = RAS_NewGameManagerQuest as RAS:NewGameManagerQuest:NewGameManagerQuestScript
    RAS:NewGameConfiguration:ShipVendorScript myShipVendorScript = RAS_ShipServicesActorREF as RAS:NewGameConfiguration:ShipVendorScript

    ;Sets up and activate map marker choosing terminal
    If(!startingMapMarkerTerminal)
        startingMapMarkerTerminal = Game.GetPlayer().PlaceAtMe(RAS_StartingMapMarkerTerminal)
    Else
        RAS_StartingMapMarkerTerminalMenu.ClearDynamicMenuItems(startingMapMarkerTerminal)
    EndIf

    If(!myShipVendorScript.NoShipSelected)
        Form[] tagReplacements = new Form[1]
        tagReplacements[0] = RAS_DynamicEntry_MapMarker_Ship
        RAS_StartingMapMarkerTerminalMenu.AddDynamicMenuItem(startingMapMarkerTerminal, 0, 1, tagReplacements)
    EndIf

    Int i = 0
    While(i < newGameManagerQuestScript.StartingLocationMapMarkersCollectionAlias.GetCount())
        Form[] tagReplacements = new Form[1]
        Form mapMarker = newGameManagerQuestScript.StartingLocationMapMarkersCollectionAlias.GetAt(i)
        Form viewportMapMarker = Game.GetFormFromFile(0xFE000003,"SFBGS008.esm")
        If(mapMarker == viewportMapMarker)
            mapMarker = RAS_DynamicEntry_MapMarker_Viewport
        EndIf
        tagReplacements[0] = mapMarker
        Bool hasShip = !myShipVendorScript.NoShipSelected
        RAS_StartingMapMarkerTerminalMenu.AddDynamicMenuItem(startingMapMarkerTerminal, 0, i + 1 + hasShip as Int, tagReplacements)
        i += 1
    EndWhile
    
    Self.RegisterForRemoteEvent(RAS_StartingMapMarkerTerminalMenu, "OnTerminalMenuItemRun")
    startingMapMarkerTerminal.Activate(Game.GetPlayer())
EndFunction

Event TerminalMenu.OnTerminalMenuItemRun(TerminalMenu akSender, int auiMenuItemID, TerminalMenu akTerminalBase, ObjectReference akTerminalRef)
    RAS:NewGameManagerQuest:NewGameManagerQuestScript newGameManagerQuestScript = RAS_NewGameManagerQuest as RAS:NewGameManagerQuest:NewGameManagerQuestScript
    RAS:NewGameConfiguration:ShipVendorScript myShipVendorScript = RAS_ShipServicesActorREF as RAS:NewGameConfiguration:ShipVendorScript

    Int index = auiMenuItemID - 1 
    If(!myShipVendorScript.NoShipSelected)
        If(index == 0)
            Game.GetPlayer().MoveTo(shipMarker)
            Game.GetPlayer().MoveTo((RAS_ShipManagerQuest as RAS:ShipManagerQuest:ShipManagerQuestScript).CurrentShip)
            Self.UnregisterForRemoteEvent(RAS_StartingMapMarkerTerminalMenu, "OnTerminalMenuItemRun")
            Return
        Else
            index -= 1
        EndIf
    EndIf
    If(index < newGameManagerQuestScript.StartingLocationMapMarkersCollectionAlias.GetCount())
        Game.GetPlayer().MoveTo(newGameManagerQuestScript.StartingLocationMapMarkersCollectionAlias.GetAt(index))
        Self.UnregisterForRemoteEvent(RAS_StartingMapMarkerTerminalMenu, "OnTerminalMenuItemRun")
    EndIf
EndEvent

