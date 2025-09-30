Scriptname RAS:NewGameConfiguration:DynamicTerminals:StartingLocation:DynamicEntryFragments:ParentsHomeFragment extends MiscObject

ObjectReference Property DynamicTerminal Mandatory Const Auto
Quest Property RAS_LocationSpawnPointFinderQuest Mandatory Const Auto
ObjectReference Property RAS_ShipServicesActorREF Mandatory Const Auto
Message Property RAS_ImpossibleToStartMessage Mandatory Const Auto
ObjectReference Property LoadElevator_FloorMarkerDUPLICATE016 Mandatory Const Auto
ObjectReference Property TargetReference  Auto

Event OnInit()
    RegisterForCustomEvent(DynamicTerminal as RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript, "SelectedFragmentTriggered")
EndEvent

Event RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript.SelectedFragmentTriggered(RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript akSender, var[] kArgs)
    If(kArgs[0] as Form == Self)
        RAS:NewGameConfiguration:ShipVendorScript myShipVendorScript = RAS_ShipServicesActorREF as RAS:NewGameConfiguration:ShipVendorScript
        If((RAS_LocationSpawnPointFinderQuest as RAS:LocationSpawnPointFinder:LocationSpawnPointFinderQuestScript).MoveToReference(TargetReference, !myShipVendorScript.NoShipSelected))
            (LoadElevator_FloorMarkerDUPLICATE016 as LoadElevatorFloorScript).SetAccessible(True)
        Else
            RAS_ImpossibleToStartMessage.Show()
        EndIf
    Endif
EndEvent

