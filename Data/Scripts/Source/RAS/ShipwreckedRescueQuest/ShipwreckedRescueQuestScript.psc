Scriptname RAS:ShipwreckedRescueQuest:ShipwreckedRescueQuestScript extends Quest

LocationAlias Property PlanetAlias Mandatory Const Auto
ReferenceAlias Property RescueBeaconAlias Mandatory Const Auto
ReferenceAlias Property ShipAlias Mandatory Const Auto
ReferenceAlias Property ShipDoorAlias Mandatory Const Auto

Function SetRescueShip(SpaceshipReference akShip)
    ShipAlias.ForceRefTo(akShip)
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
    (RescueBeaconAlias.GetReference() as RAS:ShipwreckedRescueQuest:RescueActivatorScript).MakeAvailable()
    SetStage(30)
EndEvent