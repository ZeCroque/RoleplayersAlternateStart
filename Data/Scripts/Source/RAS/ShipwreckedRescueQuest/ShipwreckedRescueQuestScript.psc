Scriptname RAS:ShipwreckedRescueQuest:ShipwreckedRescueQuestScript extends Quest Conditional

ReferenceAlias Property PlayerAlias Mandatory Const Auto
LocationAlias Property PlanetAlias Mandatory Const Auto
LocationAlias Property ShipwreckLocationAlias Mandatory Const Auto
ReferenceAlias Property ShipwreckMapMarkerAlias Mandatory Const Auto
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
Perk Property Skill_PlanetaryHabitation Mandatory Const Auto
ConditionForm Property RAS_HasPlanetaryHabRank2 Mandatory Const Auto
ConditionForm Property RAS_HasPlanetaryHabRank3 Mandatory Const Auto
ConditionForm Property RAS_HasPlanetaryHabRank4 Mandatory Const Auto

Bool Property ShowMapMarkers Auto Conditional

Location targetLoc
Location[] settlements
ObjectReference[] shipMarkers
ObjectReference shipwreckedTerminal
Int perkRank

Function SetShipwreckLocation(Location akLocation)
    ShipwreckLocationAlias.ForceLocationTo(akLocation)
    PlanetAlias.ForceLocationTo(akLocation.GetParentLocations()[0])
    ShipwreckMapMarkerAlias.RefillAlias()
    MaterialsLocationAlias.RefillAlias()
    MaterialsLocationAlias.RefillDependentAliases()

    Actor playerRef = Game.GetPlayer()
    perkRank = 0
    If(playerRef.HasPerk(Skill_PlanetaryHabitation))
        If(RAS_HasPlanetaryHabRank2.IsTrue())
            perkRank = 2
        ElseIf(RAS_HasPlanetaryHabRank3.IsTrue())
            perkRank = 3
        ElseIf(RAS_HasPlanetaryHabRank4.IsTrue())
            perkRank = 4
        Else
            perkRank = 1
        EndIf
        playerRef.RemovePerk(Skill_PlanetaryHabitation)
    EndIf

    Int i = 0
    While(i < 4)
        playerRef.AddPerk(Skill_PlanetaryHabitation)
        i += 1
    EndWhile
EndFunction

Function ClearPlanetaryHabSkillChanges()
    If(perkRank > -1)
        Actor playerRef = Game.GetPlayer()
        playerRef.RemovePerk(Skill_PlanetaryHabitation)
        Int i = 0
        While(i < perkRank)
            playerRef.AddPerk(Skill_PlanetaryHabitation)
            i += 1
        EndWhile
    EndIf
EndFunction

Function SetRescueShip(SpaceshipReference akShip)
    ShipAlias.ForceRefTo(akShip)
    ShipAlias.RefillDependentAliases()

    Self.RegisterForRemoteEvent(ShipAlias.GetShipReference(), "OnShipRampDown")

    ObjectReference[] doors = akShip.GetExteriorLoadDoors()
    ShipDoorAlias.ForceRefTo(doors[0])
    Self.RegisterForRemoteEvent(doors[0], "OnActivate")
EndFunction

Event SpaceshipReference.OnShipRampDown(SpaceshipReference akSender)
   SetStage(25)
EndEvent

Event OnQuestStarted()
    perkRank = -1
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
            j += 1
        EndIf
        i += 1
    EndWhile

    i = 0
    j = 0
    Location tmp = None
    ObjectReference tmp2 = None
    While(i < settlements.Length && settlements[i] != None)
        tmp = settlements[i]
        tmp2 = shipMarkers[i]
        j = i
        While(j > 0 && settlements[j - 1] as String > tmp as String)
            settlements[j] = settlements[j - 1]
            shipMarkers[j] = shipMarkers[j - 1]
            j -= 1
        EndWhile
        settlements[j] = tmp
        shipMarkers[j] = tmp2
        i += 1
    EndWhile

    i = 0
    While(i < settlements.Length && settlements[i] != None)
        Form[] tagReplacements = new Form[1]
        tagReplacements[0] = settlements[i]
        RAS_ShipwreckedRescueDestinationTerminalMenu.AddDynamicMenuItem(shipwreckedTerminal, 0, i + 1, tagReplacements)
        i += 1
    EndWhile

    Self.RegisterForRemoteEvent(RAS_ShipwreckedRescueDestinationTerminalMenu, "OnTerminalMenuItemRun")
    shipwreckedTerminal.Activate(Game.GetPlayer())
EndEvent

Event TerminalMenu.OnTerminalMenuItemRun(TerminalMenu akSender, int auiMenuItemID, TerminalMenu akTerminalBase, ObjectReference akTerminalRef)
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