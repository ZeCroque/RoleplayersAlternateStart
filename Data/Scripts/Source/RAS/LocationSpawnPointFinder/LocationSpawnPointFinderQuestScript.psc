Scriptname RAS:LocationSpawnPointFinder:LocationSpawnPointFinderQuestScript extends Quest

LocationAlias Property StartingLocationAlias Mandatory Const Auto
LocationAlias Property StartingLocationParentAlias Mandatory Const Auto
ReferenceAlias Property StartingLocationShipMarkerAlias Mandatory Const Auto
ReferenceAlias Property StartingLocationShipTechAlias Mandatory Const Auto
ReferenceAlias Property StartingLocationDockingPortDoorAlias Mandatory Const Auto
ReferenceAlias Property StartingLocationParentMapMarkerAlias Mandatory Const Auto
RefCollectionAlias Property StartingLocationMapMarkersCollectionAlias Mandatory Const Auto
Quest Property RAS_ShipManagerQuest Mandatory Const Auto
Keyword Property CurrentInteractionLinkedRefKeyword Mandatory Const Auto
Keyword Property LinkShipLandingMarker01 Mandatory Const Auto
Keyword Property SpaceshipDockDoor Mandatory Const Auto
Keyword Property SpaceshipLinkedExterior Mandatory Const Auto
Keyword Property DynamicallyLinkedDoorTeleportMarkerKeyword Mandatory Const Auto
Terminal Property RAS_StartingMapMarkerTerminal Mandatory Const Auto
TerminalMenu Property RAS_StartingMapMarkerTerminalMenu Mandatory Const Auto
MiscObject Property RAS_DynamicEntry_MapMarker_Ship Mandatory Const Auto
MiscObject Property RAS_DynamicEntry_MapMarker_Viewport Mandatory Const Auto
Keyword Property LocTypeOrbit Mandatory Const Auto
Keyword Property LocTypeSurface Mandatory Const Auto

ObjectReference startingMapMarkerTerminal 
ObjectReference[] cityMapMarkers
ObjectReference[] mainMapMarkers
int mainMapMarkersCount
ObjectReference shipMarker

;Fill alliases, sets the shipMarker global and returns:
;   -1 if no ship marker found
;    0 if docking port found
;    1 if spaceport marker found
;    2 if regular landing marker found (not tied to shiptech)
Int Function FindShipMarkerForLocation(Location akLocation)
    ;Fill aliases
    StartingLocationAlias.ForceLocationTo(akLocation)
    Location[] parentLocations = akLocation.GetParentLocations()
    If(parentLocations.Length)
        StartingLocationParentAlias.ForceLocationTo(parentLocations[0])
    EndIf
    StartingLocationMapMarkersCollectionAlias.RefillAlias()
    StartingLocationShipMarkerAlias.RefillAlias()
    StartingLocationParentMapMarkerAlias.RefillAlias()

    ;Sets up spaceship markers if applicable
    StartingLocationDockingPortDoorAlias.RefillAlias()
    ObjectReference shipDockingDoor = StartingLocationDockingPortDoorAlias.GetReference()
    
    ;Find spaceship docking ports
    If(shipDockingDoor && StartingLocationParentMapMarkerAlias.GetReference())
        Cell shipExteriorCell = shipDockingDoor.GetParentCell().GetParentRef().GetLinkedCell(SpaceshipLinkedExterior)

        ObjectReference[] dockingPorts = shipDockingDoor.GetRefsLinkedToMe(SpaceshipDockDoor)
        Int i = 0
        While(i < dockingPorts.Length)
            If(dockingPorts[i].GetParentCell() == shipExteriorCell)
                shipMarker = dockingPorts[i]
                Return 0
            EndIf
            i += 1
        EndWhile
    EndIf
 
    StartingLocationShipTechAlias.RefillAlias()
    ObjectReference shipTech = StartingLocationShipTechAlias.GetReference()
    If(shipTech)
        ;has ship tech (settlement), find ship marker linked to it
        shipMarker = shipTech.GetLinkedRef(LinkShipLandingMarker01)
        Return 1
    Else
        shipMarker = StartingLocationShipMarkerAlias.GetReference()
        If(shipMarker)
            Return 2
        EndIf
    EndIf

    Return -1
EndFunction

; /!\ It's necessary to call FindShipMarkerForLocation beforehand /!\
;Moves player and/or ship to a spacestation reference. 
;    If moving player and ship, will move to ship
;    If moving only player but no destination provided, will move to the docking port door
Function MoveToSpacestationReference(SpaceshipReference ship, Bool moveShip, Bool movePlayer = True, ObjectReference playerDestination = None)
    If(moveShip)
        ship.MoveTo(StartingLocationParentMapMarkerAlias.GetReference())
        ship.InstantDock(shipMarker)
        ship.Enable()
    EndIf
    
    If(movePlayer)
        If(moveShip)
            Game.GetPlayer().MoveTo(ship)
        Else
            If(!playerDestination)
                Game.GetPlayer().MoveTo(StartingLocationDockingPortDoorAlias.GetReference().GetLinkedRef(DynamicallyLinkedDoorTeleportMarkerKeyword))
            Else
                Game.GetPlayer().MoveTo(playerDestination)
            EndIf
        EndIf
    EndIf
EndFunction

; /!\ It's necessary to call FindShipMarkerForLocation beforehand /!\
;Moves player and/or ship to a planet reference. 
;    If moving player and ship, will move to ship
;    If moving only player but no destination provided, will prompt for a map marker if several available or will move to the ship marker elsewise
Function MoveToPlanetReference(SpaceshipReference ship, Bool moveShip, Bool movePlayer = True, ObjectReference playerDestination = None)
    If(moveShip)
        ;Sometimes the ship tech could lead to a secondary ship marker that can be occupied, so we remove that ship if applicable (eg: RedMile)
        ObjectReference[] linkedShips = shipMarker.GetRefsLinkedToMe(CurrentInteractionLinkedRefKeyword)
        If(linkedShips.Length)
            linkedShips[0].Disable()
        EndIf

        ship.MoveTo(shipMarker)
        ship.SetLinkedRef(shipMarker, CurrentInteractionLinkedRefKeyword)
        ship.Enable()
    EndIf

    If(movePlayer)
        If(!playerDestination)
            If(StartingLocationMapMarkersCollectionAlias.GetCount() <= 1)
                ;If one map marker or less, skip menu
                If(moveShip)
                    ;We move to shipMarker before moving to ship to ensure landing cell has loaded properly
                    Game.GetPlayer().MoveTo(shipMarker)
                    Game.GetPlayer().MoveTo(ship)
                Else
                    ;We move to shipMarker instead of mapMarker because it can have strange placement on some settlements (eg: RedMile)
                    ;In addition it allow us to handle the same way the no map marker and single map marker cases
                    Game.GetPlayer().MoveTo(shipMarker)
                EndIf
            Else
                SelectMapMarkerAndMove(moveShip)
            EndIf
        Else
            Game.GetPlayer().MoveTo(playerDestination)
        EndIf
    EndIf
EndFunction

; Attempts to find a marker to move ship, and then move ship to it and player to given ref if applicable
; Returns wether or not it succeeded
Bool Function MoveToReference(ObjectReference targetReference, Bool moveShip)
    SpaceshipReference CurrentShip = (RAS_ShipManagerQuest as RAS:ShipManagerQuest:ShipManagerQuestScript).CurrentShip

    Location currentLocation = targetReference.GetCurrentLocation() 
    Location landableLocation = None
    Location[] parents = targetReference.GetCurrentLocation().GetParentLocations()
    Int i = 0
    While(i < parents.Length)
        If(parents[i].HasKeyword(LocTypeOrbit))
            landableLocation = currentLocation
            i = parents.Length ;break
        ElseIf(parents[i].HasKeyword(LocTypeSurface))
            If(i == 0)
                landableLocation = currentLocation
            Else
                landableLocation = parents[i - 1]
            EndIf
            i = parents.Length ;break
        EndIf
        i += 1
    EndWhile
    
    If(landableLocation)
        Int shipMarkerType = FindShipMarkerForLocation(landableLocation)
        If(shipMarkerType == 0) ;spacestation
            MoveToSpacestationReference(CurrentShip, moveShip, True, targetReference)
            Return True
        ElseIf(shipMarkerType > 0) ;planet (settlement/POI)(undefined behavior if no ship tech (2) and more than one ship landing marker)
            MoveToPlanetReference(CurrentShip, moveShip, True, targetReference)
            Return True
        EndIf
    EndIf
    ;Nothing appropriate to move
    Return False
EndFunction

; Attempts to find a marker to move ship and/or player in given location
; Returns wether or not it succeeded
Bool Function MoveToLocation(Location akLocation, Bool moveShip, Bool movePlayer = True)
    SpaceshipReference CurrentShip = (RAS_ShipManagerQuest as RAS:ShipManagerQuest:ShipManagerQuestScript).CurrentShip

    Int shipMarkerType = FindShipMarkerForLocation(akLocation)
    If(shipMarkerType == 0) ;spacestation
        MoveToSpacestationReference(CurrentShip, moveShip, movePlayer)
        Return True
    ElseIf(shipMarkerType > 0) ;planet (settlement/POI)(undefined behavior if no ship tech (2) and more than one ship landing marker)
        MoveToPlanetReference(CurrentShip, moveShip, movePlayer)
        Return True
    ElseIf(movePlayer && StartingLocationMapMarkersCollectionAlias.GetCount()) ;Fallback to the only known ref we have
        Game.GetPlayer().MoveTo(StartingLocationMapMarkersCollectionAlias.GetAt(0))
        Return True
    EndIf
    ;Nothing appropriate to move
    Return False
EndFunction

ObjectReference[] Function InsertionSort(ObjectReference[] akArray)
    Int i = 1
    Int j = 0
    ObjectReference tmp = None
    While(i < akArray.Length && akArray[i] != None)
        tmp = akArray[i]
        j = i
        While(j > 0 && akArray[j - 1] as String > tmp as String)
            akArray[j] = akArray[j - 1]
            j -= 1
        EndWhile
        akArray[j] = tmp
        i += 1
    EndWhile
    return akArray
EndFunction

Function AddTerminalEntries(ObjectReference[] mapMarkers, Int offset)
    Form viewportMapMarker = Game.GetFormFromFile(0xFE000003,"SFBGS008.esm")
    Form[] tagReplacements = new Form[1]

    Int i = 0
    While(i < mapMarkers.Length && mapMarkers[i] != None)
        Form mapMarker = mapMarkers[i]
        If(mapMarker == viewportMapMarker) ;The undiscovered name of viewport is crap, so we hardcoded a fix
            mapMarker = RAS_DynamicEntry_MapMarker_Viewport
        EndIf
        tagReplacements[0] = mapMarker
        RAS_StartingMapMarkerTerminalMenu.AddDynamicMenuItem(startingMapMarkerTerminal, 0, i + 1 + offset, tagReplacements)
        i += 1
    EndWhile    
EndFunction

Function SelectMapMarkerAndMove(Bool moveShip)
    ;Sets up and activate map marker choosing terminal
    If(!startingMapMarkerTerminal)
        startingMapMarkerTerminal = Game.GetPlayer().PlaceAtMe(RAS_StartingMapMarkerTerminal)
    Else
        RAS_StartingMapMarkerTerminalMenu.ClearDynamicMenuItems(startingMapMarkerTerminal)
    EndIf

    ;Add ship entry first if applicable
    If(moveShip)
        Form[] tagReplacements = new Form[1]
        tagReplacements[0] = RAS_DynamicEntry_MapMarker_Ship
        RAS_StartingMapMarkerTerminalMenu.AddDynamicMenuItem(startingMapMarkerTerminal, 0, 1, tagReplacements)
    EndIf

    ;Split update-added city map markers and others and then add them to terminal
    ObjectReference[] mapMarkers = StartingLocationMapMarkersCollectionAlias.GetArray()
    cityMapMarkers = new ObjectReference[mapMarkers.Length]
    mainMapMarkers = new ObjectReference[mapMarkers.Length]
    Int i = 0
    Int j = 0
    Int k = 0
    String mapMarkerEditorId
    While(i < mapMarkers.Length)
        mapMarkerEditorId = mapMarkers[i] as String
        If(mapMarkerEditorId > "[ObjectReference < CithMapMarker_A" && mapMarkerEditorId < "[ObjectReference <CithMapMarker_Z") ;Akila city typo
            cityMapMarkers[j] = mapMarkers[i]
            j += 1
        Else
            If(mapMarkerEditorId > "[ObjectReference <CityMapMarker_A" && mapMarkerEditorId < "[ObjectReference <CityMapMarker_Z")
                cityMapMarkers[j] = mapMarkers[i]
                j += 1
            Else
                If(mapMarkerEditorId > "[ObjectReference <CityMapMarkers_A" && mapMarkerEditorId < "[ObjectReference <CityMapMarkers_Z")
                    cityMapMarkers[j] = mapMarkers[i]
                    j += 1
                Else
                    mainMapMarkers[k] = mapMarkers[i]
                    k += 1
                EndIf
            EndIf
        EndIf
        i += 1
    EndWhile
    mainMapMarkersCount = k + 1
    AddTerminalEntries(InsertionSort(mainMapMarkers), 1) ;offset by 1 because index 0 is for ship move
    AddTerminalEntries(InsertionSort(cityMapMarkers), mainMapMarkersCount + 1) ;offset by 1 because index 0 is for ship move
    
    Self.RegisterForRemoteEvent(RAS_StartingMapMarkerTerminalMenu, "OnTerminalMenuItemRun")
    startingMapMarkerTerminal.Activate(Game.GetPlayer())
EndFunction

Event TerminalMenu.OnTerminalMenuItemRun(TerminalMenu akSender, int auiMenuItemID, TerminalMenu akTerminalBase, ObjectReference akTerminalRef)
    Int index = auiMenuItemID - 1 
    If(index == 0)
        Game.GetPlayer().MoveTo(shipMarker)
        Game.GetPlayer().MoveTo((RAS_ShipManagerQuest as RAS:ShipManagerQuest:ShipManagerQuestScript).CurrentShip)
        Self.UnregisterForRemoteEvent(RAS_StartingMapMarkerTerminalMenu, "OnTerminalMenuItemRun")
    Else
        index -= 1
        If(index < StartingLocationMapMarkersCollectionAlias.GetCount())
            If(index < mainMapMarkersCount)
                Game.GetPlayer().MoveTo(mainMapMarkers[index])
            Else

                Game.GetPlayer().MoveTo(cityMapMarkers[index - mainMapMarkersCount])
            EndIf
            Self.UnregisterForRemoteEvent(RAS_StartingMapMarkerTerminalMenu, "OnTerminalMenuItemRun")
        EndIf
    EndIf
EndEvent