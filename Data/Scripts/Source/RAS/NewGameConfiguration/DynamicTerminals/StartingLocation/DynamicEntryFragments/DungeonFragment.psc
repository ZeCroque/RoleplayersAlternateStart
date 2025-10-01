Scriptname RAS:NewGameConfiguration:DynamicTerminals:StartingLocation:DynamicEntryFragments:DungeonFragment extends MiscObject

ObjectReference Property DynamicTerminal Mandatory Const Auto
Quest Property RAS_LocationSpawnPointFinderQuest Mandatory Const Auto
ObjectReference Property RAS_ShipServicesActorREF Mandatory Const Auto
Message Property RAS_ImpossibleToStartMessage Mandatory Const Auto

Event OnInit()
    RegisterForCustomEvent(DynamicTerminal as RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript, "SelectedFragmentTriggered")
EndEvent

Event RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript.SelectedFragmentTriggered(RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript akSender, var[] kArgs)
    If(kArgs[0] as Form == Self)
        RAS:NewGameConfiguration:ShipVendorScript myShipVendorScript = RAS_ShipServicesActorREF as RAS:NewGameConfiguration:ShipVendorScript
        RAS:LocationSpawnPointFinder:LocationSpawnPointFinderQuestScript locationSpawnPointFinderQuestScript = (RAS_LocationSpawnPointFinderQuest as RAS:LocationSpawnPointFinder:LocationSpawnPointFinderQuestScript)
        If(!locationSpawnPointFinderQuestScript.MoveToLocation(locationSpawnPointFinderQuestScript.RandomDungeon.GetLocation(), !myShipVendorScript.NoShipSelected))
            RAS_ImpossibleToStartMessage.Show()
        EndIf
    Endif
EndEvent

