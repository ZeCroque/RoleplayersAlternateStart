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

Bool Property ShowMapMarkers Auto Conditional
Bool Property IsEnabled Auto Conditional

Event OnQuestStarted()
    Location targetLocation = (RAS_LocationSpawnPointFinderQuest as RAS:LocationSpawnPointFinder:LocationSpawnPointFinderQuestScript).TargetLocation
    StartingLocationAlias.ForceLocationTo(targetLocation)
    PlanetAlias.ForceLocationTo(targetLocation.GetParentLocations()[0])
    StartingLocationMapMarkerAlias.ForceRefTo((RAS_LocationSpawnPointFinderQuest as RAS:LocationSpawnPointFinder:LocationSpawnPointFinderQuestScript).StartingLocationMapMarkersCollectionAlias.GetAt(0))
    MaterialsLocationAlias.RefillAlias()
    MaterialsLocationAlias.RefillDependentAliases()
    
    RAS:ShipManagerQuest:ShipManagerQuestScript rasShipManager = (RAS_ShipManagerQuest as RAS:ShipManagerQuest:ShipManagerQuestScript)
    
    ShipAlias.ForceRefTo(rasShipManager.CurrentShip)
    ShipAlias.RefillDependentAliases()
    ShipPilotChair.GetReference().BlockActivation(True, False)
    rasShipManager.InitNoneShip()
    SQ_PlayerShipScript shipQuest = SQ_PlayerShip as SQ_PlayerShipScript
    shipQuest.RemovePlayerShip(ShipAlias.GetShipReference())
    shipQuest.PlayerShip.ForceRefTo((RAS_ShipManagerQuest as RAS:ShipManagerQuest:ShipManagerQuestScript).RAS_NoneShipReference)

    SetStage(0)
EndEvent