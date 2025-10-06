Scriptname RAS:ShipwreckedRescueQuest:ShipwreckedRescueQuestScript extends Quest

LocationAlias Property PlanetAlias Mandatory Const Auto
LocationAlias Property ShipwreckLocationAlias Mandatory Const Auto
ReferenceAlias Property RescueBeaconAlias Mandatory Const Auto
ReferenceAlias Property ShipAlias Mandatory Const Auto
ReferenceAlias Property ShipDoorAlias Mandatory Const Auto
ReferenceAlias Property ShipMapMarkerAlias Mandatory Const Auto
LocationAlias Property MaterialsLocationAlias Mandatory Const Auto
Quest Property RAS_LocationSpawnPointFinderQuest Mandatory Const Auto
Terminal Property RAS_ShipwreckedRescueDestinationTerminal Mandatory Const Auto
TerminalMenu Property RAS_ShipwreckedRescueDestinationTerminalMenu Mandatory Const Auto
Keyword Property LocTypeSurface Mandatory Const Auto
Keyword Property LinkShipLandingMarker01 Mandatory Const Auto

Location targetLoc
Location[] settlements
ObjectReference[] shipMarkers
ObjectReference shipwreckedTerminal

Function SetShipwreckLocation(Location akLocation)
    ShipwreckLocationAlias.ForceLocationTo(akLocation)
    PlanetAlias.ForceLocationTo(akLocation.GetParentLocations()[0])
    MaterialsLocationAlias.RefillAlias()
    MaterialsLocationAlias.RefillDependentAliases()
EndFunction

Function SetRescueShip(SpaceshipReference akShip)
    ShipAlias.ForceRefTo(akShip)
    ShipAlias.RefillDependentAliases()
    ObjectReference[] ramps = akShip.GetLandingRamps()
    Self.RegisterForRemoteEvent(ramps[0], "OnOpen")

    ObjectReference[] doors = akShip.GetExteriorLoadDoors()
    ShipDoorAlias.ForceRefTo(doors[0])
    Self.RegisterForRemoteEvent(doors[0], "OnActivate")
EndFunction

Event ObjectReference.OnOpen(ObjectReference akSender, ObjectReference akActionRef)
    SetStage(25)
EndEvent

Event ObjectReference.OnActivate(ObjectReference akSender, ObjectReference akActionRef)
    RefCollectionAlias shipTechCollectionAlias = (RAS_LocationSpawnPointFinderQuest as RAS:LocationSpawnPointFinder:LocationSpawnPointFinderQuestScript).ShipTechCollectionAlias
    
    If(!shipwreckedTerminal)
        shipwreckedTerminal = Game.GetPlayer().PlaceAtMe(RAS_ShipwreckedRescueDestinationTerminal)
        settlements = new Location[shipTechCollectionAlias.GetCount()]
        shipMarkers = new ObjectReference[shipTechCollectionAlias.GetCount()]
    EndIf

    RAS_ShipwreckedRescueDestinationTerminalMenu.ClearDynamicMenuItems(shipwreckedTerminal)
    Int i = 0
    Int j = 0
    While(i < shipTechCollectionAlias.GetCount())
        Location shipTechLocation = shipTechCollectionAlias.GetAt(i).GetCurrentLocation()
         If(shipTechLocation && shipTechLocation.GetParentLocations()[0].HasKeyword(LocTypeSurface))
            settlements[j] = shipTechLocation
            shipMarkers[j] = shipTechCollectionAlias.GetAt(i).GetLinkedRef(LinkShipLandingMarker01)
            Form[] tagReplacements = new Form[1]
            tagReplacements[0] = shipTechLocation
            RAS_ShipwreckedRescueDestinationTerminalMenu.AddDynamicMenuItem(shipwreckedTerminal, 0, j + 1, tagReplacements)
            j += 1
        EndIf
        i += 1
    EndWhile

    Self.RegisterForRemoteEvent(RAS_ShipwreckedRescueDestinationTerminalMenu, "OnTerminalMenuItemRun")
    shipwreckedTerminal.Activate(Game.GetPlayer())
EndEvent

Event TerminalMenu.OnTerminalMenuItemRun(TerminalMenu akSender, int auiMenuItemID, TerminalMenu akTerminalBase, ObjectReference akTerminalRef)
    ;todo movetoship tecch only, move samaratain and move to ship
    Int index = auiMenuItemID - 1
    If(index < settlements.Length)
        SetStage(30)
        (RescueBeaconAlias.GetReference() as RAS:ShipwreckedRescueQuest:RescueActivatorScript).MakeAvailable()
        Self.UnregisterForRemoteEvent(RAS_ShipwreckedRescueDestinationTerminalMenu, "OnTerminalMenuItemRun")

        RAS:LocationSpawnPointFinder:LocationSpawnPointFinderQuestScript locationSpawnPointFinderQuestScript = RAS_LocationSpawnPointFinderQuest as RAS:LocationSpawnPointFinder:LocationSpawnPointFinderQuestScript
        locationSpawnPointFinderQuestScript.MoveShipToMarker(ShipAlias.GetShipReference(), shipMarkers[index])
        Game.GetPlayer().MoveTo(shipMarkers[index])
        Game.GetPlayer().MoveTo(ShipAlias.GetReference())
    EndIf
EndEvent