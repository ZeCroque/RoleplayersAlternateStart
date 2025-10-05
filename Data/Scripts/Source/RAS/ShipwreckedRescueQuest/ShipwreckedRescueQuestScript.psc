Scriptname RAS:ShipwreckedRescueQuest:ShipwreckedRescueQuestScript extends Quest

LocationAlias Property PlanetAlias Mandatory Const Auto
LocationAlias Property ShipwreckLocationAlias Mandatory Const Auto
ReferenceAlias Property RescueBeaconAlias Mandatory Const Auto
ReferenceAlias Property ShipAlias Mandatory Const Auto
ReferenceAlias Property ShipDoorAlias Mandatory Const Auto
LocationAlias Property MaterialsLocationAlias Mandatory Const Auto
Quest Property RAS_LocationSpawnPointFinderQuest Mandatory Const Auto
ObjectReference Property RAS_StartingLocationActivator Mandatory Const Auto
Terminal Property RAS_ShipwreckedRescueDestinationTerminal Mandatory Const Auto
TerminalMenu Property RAS_StartingLocationTerminal_Submenu Mandatory Const Auto

Location targetLoc
Form[] settlementsArray
ObjectReference shipwreckedTerminal

Function SetShipwreckLocation(Location akLocation)
    ShipwreckLocationAlias.ForceLocationTo(akLocation)
    PlanetAlias.ForceLocationTo(akLocation.GetParentLocations()[0])
    MaterialsLocationAlias.RefillAlias()
    MaterialsLocationAlias.RefillDependentAliases()
EndFunction

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
    If(!shipwreckedTerminal)
        shipwreckedTerminal = Game.GetPlayer().PlaceAtMe(RAS_ShipwreckedRescueDestinationTerminal)
    EndIf

    RAS_StartingLocationTerminal_Submenu.ClearDynamicMenuItems(shipwreckedTerminal)
    settlementsArray = (RAS_StartingLocationActivator as RAS:NewGameConfiguration:DynamicTerminals:StartingLocation:StartingLocationActivatorScript).RAS_SettlementsLocationList.GetArray()
    Int i = 0
    While(i < settlementsArray.Length)
            Form[] tagReplacements = new Form[1]
            tagReplacements[0] = settlementsArray[i]
            RAS_StartingLocationTerminal_Submenu.AddDynamicMenuItem(shipwreckedTerminal, 0, i + 1, tagReplacements)
        i += 1
    EndWhile

    Self.RegisterForRemoteEvent(RAS_StartingLocationTerminal_Submenu, "OnTerminalMenuItemRun")
    shipwreckedTerminal.Activate(Game.GetPlayer())
EndEvent

Event TerminalMenu.OnTerminalMenuItemRun(TerminalMenu akSender, int auiMenuItemID, TerminalMenu akTerminalBase, ObjectReference akTerminalRef)
    ;todo movetoship tecch only, move samaratain and move to ship
    Int index = auiMenuItemID - 1
    If(index < settlementsArray.Length)
        (RescueBeaconAlias.GetReference() as RAS:ShipwreckedRescueQuest:RescueActivatorScript).MakeAvailable()
        SetStage(30)
        targetLoc = settlementsArray[index] as Location
        (RAS_LocationSpawnPointFinderQuest as RAS:LocationSpawnPointFinder:LocationSpawnPointFinderQuestScript).MoveToLocation(targetLoc, False)
         Self.UnregisterForRemoteEvent(RAS_StartingLocationTerminal_Submenu, "OnTerminalMenuItemRun")
    EndIf
EndEvent