Scriptname RAS_TestActivatorScript extends ObjectReference Const

ObjectReference Property RAS_NoneShipReference Mandatory Const Auto
ObjectReference Property Frontier_ModularREF Mandatory Const Auto
ActorValue Property SpaceshipRegistration Mandatory Const Auto

Event OnActivate(ObjectReference akActionRef)
	Game.AddPlayerOwnedShip(RAS_NoneShipReference as SpaceshipReference)
	Game.TrySetPlayerHomeSpaceShip(RAS_NoneShipReference)
	RAS_NoneShipReference.SetValue(SpaceshipRegistration, 1)
 	RAS_NoneShipReference.RemoveAllItems()
	Game.RemovePlayerOwnedShip(Frontier_ModularREF as SpaceshipReference)
EndEvent
