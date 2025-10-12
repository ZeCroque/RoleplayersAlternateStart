Scriptname RAS:BrokenShipQuest:BrokenShipQuestScript extends Quest Conditional

LocationAlias Property StartingLocationAlias Mandatory Const Auto
LocationAlias Property PlanetAlias Mandatory Const Auto
LocationAlias Property MaterialsLocationAlias Mandatory Const Auto
ReferenceAlias Property StartingLocationMapMarkerAlias Mandatory Const Auto
ReferenceAlias Property ShipAlias Mandatory Const Auto
ReferenceAlias Property ShipPilotChair Mandatory Const Auto
Quest Property RAS_LocationSpawnPointFinderQuest Mandatory Const Auto
Quest Property RAS_ShipManagerQuest Mandatory Const Auto

InputEnableLayer Property InputLayer Auto Hidden
Bool Property ShowMapMarkers Auto Conditional
Bool Property IsEnabled Auto Conditional

Event OnQuestStarted()
    Location targetLocation = (RAS_LocationSpawnPointFinderQuest as RAS:LocationSpawnPointFinder:LocationSpawnPointFinderQuestScript).TargetLocation
    StartingLocationAlias.ForceLocationTo(targetLocation)
    PlanetAlias.ForceLocationTo(targetLocation.GetParentLocations()[0])
    StartingLocationMapMarkerAlias.RefillAlias()
    MaterialsLocationAlias.RefillAlias()
    MaterialsLocationAlias.RefillDependentAliases()
    
    ShipAlias.ForceRefTo((RAS_ShipManagerQuest as RAS:ShipManagerQuest:ShipManagerQuestScript).CurrentShip)
    ShipAlias.RefillDependentAliases()
    ShipPilotChair.GetReference().BlockActivation(True, False)

    InputLayer = InputEnableLayer.Create()
    InputLayer.EnableFarTravel(False)
    InputLayer.EnableGravJump(False)
    InputLayer.EnableTakeoff(False)
    InputLayer.EnableFastTravel(False)

    SetStage(0)
EndEvent