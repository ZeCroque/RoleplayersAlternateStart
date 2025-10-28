Scriptname RAS:ShipManagerQuest:ShipManagerQuestScript extends Quest Conditional

Quest Property DialogueShipServices Mandatory Const Auto
ObjectReference Property RAS_ShipVendorMarker Mandatory Const Auto
ActorValue Property SpaceshipRegistration Mandatory Const Auto
Form Property RAS_NoneShip Mandatory Const Auto 
GlobalVariable Property MQ204_TurnOffCF01Arrest Mandatory Const Auto

SpaceshipReference Property CurrentShip Auto Hidden
SpaceshipReference Property RAS_NoneShipReference Auto Hidden
Bool Property PedestrianStart Auto Conditional
InputEnableLayer InputLayer

Function InitNoneShip()
    ;Sets the none ship to player
    RAS_NoneShipReference = RAS_ShipVendorMarker.PlaceShipAtMe(RAS_NoneShip)
    Game.AddPlayerOwnedShip(RAS_NoneShipReference)
    Game.TrySetPlayerHomeSpaceShip(RAS_NoneShipReference)
    RAS_NoneShipReference.SetValue(SpaceshipRegistration, 1)
    CurrentShip = RAS_NoneShipReference

    ;Disable space
    InputLayer = InputEnableLayer.Create()
    InputLayer.EnableFarTravel(False)
    InputLayer.EnableGravJump(False)
    InputLayer.EnableTakeoff(False)
    InputLayer.EnableFastTravel(False)

    ;We start as pedestrian and will eventually update when player enters black hole
    PedestrianStart = True

    ;Prevent sysdef quest from triggering
    MQ204_TurnOffCF01Arrest.SetValueInt(1)

    ;Removes ship services techs dialogs
    DialogueShipServices.Stop()
EndFunction

Function SetupPlayerShip(SpaceshipReference akShip)
    ;Delete none ship ref and finalize ship setup
    RAS_NoneShipReference = None
    akShip.SetExteriorLoadDoorInaccessible(False)

    ;Enable space
    InputLayer.Delete()

    ;No longer pedestrian
    PedestrianStart = False

    ;Enables back sysdef quest
    MQ204_TurnOffCF01Arrest.SetValueInt(0)

    ;Add back ship services tech dialogs
    DialogueShipServices.Reset()
    DialogueShipServices.Start()

    ;Shutting player alias script
    Stop()
EndFunction