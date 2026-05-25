Scriptname RAS:BrokenShipQuest:BrokenShipQuestScript extends Quest Conditional

LocationAlias Property StartingLocationAlias Mandatory Const Auto
LocationAlias Property PlanetAlias Mandatory Const Auto
LocationAlias Property MaterialsLocationAlias Mandatory Const Auto
ReferenceAlias Property StartingLocationMapMarkerAlias Mandatory Const Auto
ReferenceAlias Property ShipAlias Mandatory Const Auto
ReferenceAlias Property ShipPilotChair Mandatory Const Auto
Quest Property RAS_LocationSpawnPointFinderQuest Mandatory Const Auto
Quest Property RAS_ShipManagerQuest Mandatory Const Auto
Quest Property SQ_PlayerShip Mandatory Const Auto
Keyword Property CurrentInteractionLinkedRefKeyword Mandatory Const Auto
ConditionForm Property RAS_PlayerSelectedRandomStart Mandatory Const Auto
ObjectReference Property RAS_StartingLocationTerminalREF Mandatory Const Auto
ObjectReference Property RAS_GameStartCellMarkerREF Mandatory Const Auto

Bool Property ShowMapMarkers Auto Conditional
Bool Property IsEnabled Auto Conditional

Function RegisterForShipEvents()
    SQ_PlayerShipScript shipQuest = SQ_PlayerShip as SQ_PlayerShipScript
    Self.RegisterForRemoteEvent(shipQuest.PlayerShip, "OnAliasChanged")
    Self.RegisterForRemoteEvent(shipQuest.PlayerShip.GetShipReference(), "OnLocationChange")
EndFunction

Function SetupMaterials()
    Location targetLocation = (RAS_LocationSpawnPointFinderQuest as RAS:LocationSpawnPointFinder:LocationSpawnPointFinderQuestScript).TargetLocation
    StartingLocationAlias.ForceLocationTo(targetLocation)
    PlanetAlias.ForceLocationTo(targetLocation.GetParentLocations()[0])
    StartingLocationMapMarkerAlias.ForceRefTo((RAS_LocationSpawnPointFinderQuest as RAS:LocationSpawnPointFinder:LocationSpawnPointFinderQuestScript).StartingLocationMapMarkersCollectionAlias.GetAt(0))
    MaterialsLocationAlias.RefillAlias()
    MaterialsLocationAlias.RefillDependentAliases()
EndFunction

Event OnQuestStarted()
    If(RAS_PlayerSelectedRandomStart.IsTrue())
        Int randomAliasId = ((RAS_StartingLocationTerminalREF as RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript).GetCurrentFragment() as RAS:NewGameConfiguration:DynamicTerminals:StartingLocation:DynamicEntryFragments:DefaultRandomLocationFragment).AliasId
        While(!MaterialsLocationAlias.GetLocation())
            SetupMaterials()
            If(!MaterialsLocationAlias.GetLocation())
                LocationAlias targetLoc = (RAS_LocationSpawnPointFinderQuest as RAS:LocationSpawnPointFinder:LocationSpawnPointFinderQuestScript).GetAlias(randomAliasId) as LocationAlias
                targetLoc.RefillAlias()
                Game.GetPlayer().MoveTo(RAS_GameStartCellMarkerREF)
                (RAS_LocationSpawnPointFinderQuest as RAS:LocationSpawnPointFinder:LocationSpawnPointFinderQuestScript).MoveToLocation(targetLoc.GetLocation(), True)
            EndIf
        EndWhile
    EndIf
    
    RAS:ShipManagerQuest:ShipManagerQuestScript rasShipManager = (RAS_ShipManagerQuest as RAS:ShipManagerQuest:ShipManagerQuestScript)
    
    ShipAlias.ForceRefTo(rasShipManager.CurrentShip)
    ShipAlias.RefillDependentAliases()
    ShipPilotChair.GetReference().BlockActivation(True, False)

    SQ_PlayerShipScript shipQuest = SQ_PlayerShip as SQ_PlayerShipScript
    Self.RegisterForRemoteEvent(shipQuest.PlayerShips, "OnAliasChanged")
    rasShipManager.InitNoneShip()
    rasShipManager.CurrentShip = ShipAlias.GetShipReference()
    rasShipManager.UpdateCurrentShipSize()
    shipQuest.RemovePlayerShip(ShipAlias.GetShipReference())
    shipQuest.PlayerShip.ForceRefTo((RAS_ShipManagerQuest as RAS:ShipManagerQuest:ShipManagerQuestScript).RAS_NoneShipReference)

    RegisterForShipEvents()

    SetStage(0)
EndEvent

Event RefCollectionAlias.OnAliasChanged(RefCollectionAlias akSender, ObjectReference akObject, bool abRemove)
    If(abRemove)
        SpaceshipReference brokenShip = ShipAlias.GetShipReference()
        If(akObject == brokenShip)
            brokenShip.Enable()
            brokenShip.SetLinkedRef((RAS_LocationSpawnPointFinderQuest as RAS:LocationSpawnPointFinder:LocationSpawnPointFinderQuestScript).GetShipMarker(), CurrentInteractionLinkedRefKeyword)
            Self.UnregisterForRemoteEvent((SQ_PlayerShip as SQ_PlayerShipScript).PlayerShips, "OnAliasChanged")
        EndIf
    EndIf
EndEvent

Event ReferenceAlias.OnAliasChanged(ReferenceAlias akSource, ObjectReference akObject, bool abRemove)
    If(abRemove)    
        Self.UnregisterForRemoteEvent(akObject as SpaceshipReference, "OnLocationChange")        
    Else
        Self.RegisterForRemoteEvent(akObject as SpaceshipReference, "OnLocationChange")
    EndIf
EndEvent

Function HandleLocationChanged(Location akNewLoc)
    If(RAS_PlayerSelectedRandomStart.IsTrue() && ShipAlias.GetReference())
        SetStage(1)
        Self.UnregisterForAllRemoteEvents()
    EndIf
EndFunction

Event SpaceshipReference.OnLocationChange(SpaceshipReference akSource, Location akOldLoc, Location akNewLoc)
    HandleLocationChanged(akNewLoc)
EndEvent
