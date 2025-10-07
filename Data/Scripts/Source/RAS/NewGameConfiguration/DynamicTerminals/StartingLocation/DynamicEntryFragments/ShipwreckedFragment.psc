Scriptname RAS:NewGameConfiguration:DynamicTerminals:StartingLocation:DynamicEntryFragments:ShipwreckedFragment extends MiscObject

ObjectReference Property DynamicTerminal Mandatory Const Auto
Quest Property RAS_LocationSpawnPointFinderQuest Mandatory Const Auto
ObjectReference Property RAS_ShipServicesActorREF Mandatory Const Auto
Message Property RAS_ImpossibleToStartMessage Mandatory Const Auto
TerminalMenu Property RAS_RandomStartConfigurationTerminalMenu Mandatory Const Auto
Quest Property RAS_ShipwreckedRescueQuest Mandatory Const Auto

Int AliasId = 12

Event OnInit()
    RegisterForCustomEvent(DynamicTerminal as RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript, "SelectedFragmentTriggered")
EndEvent

Event RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript.SelectedFragmentTriggered(RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript akSender, var[] kArgs)
    If(kArgs[0] as Form == Self)
        Self.RegisterForRemoteEvent(RAS_RandomStartConfigurationTerminalMenu, "OnTerminalMenuItemRun")
        (RAS_LocationSpawnPointFinderQuest as RAS:LocationSpawnPointFinder:LocationSpawnPointFinderQuestScript).StartRandomLocationConfigurationTerminal(AliasId)
    Endif
EndEvent

Event TerminalMenu.OnTerminalMenuItemRun(TerminalMenu akSender, int auiMenuItemID, TerminalMenu akTerminalBase, ObjectReference akTerminalRef)
    If(akTerminalBase == RAS_RandomStartConfigurationTerminalMenu && auiMenuItemID == 3)
        RAS:NewGameConfiguration:ShipVendorScript myShipVendorScript = RAS_ShipServicesActorREF as RAS:NewGameConfiguration:ShipVendorScript
        RAS:LocationSpawnPointFinder:LocationSpawnPointFinderQuestScript locationSpawnPointFinderQuestScript = (RAS_LocationSpawnPointFinderQuest as RAS:LocationSpawnPointFinder:LocationSpawnPointFinderQuestScript)
        LocationAlias targetLoc = locationSpawnPointFinderQuestScript.GetAlias(AliasId) as LocationAlias
        targetLoc.RefillAlias()
        If(locationSpawnPointFinderQuestScript.MoveToLocation(targetLoc.GetLocation(), !myShipVendorScript.NoShipSelected))
            RAS_ShipwreckedRescueQuest.Start()
            (RAS_ShipwreckedRescueQuest as RAS:ShipwreckedRescueQuest:ShipwreckedRescueQuestScript).SetShipwreckLocation(targetLoc.GetLocation())
            RAS_ShipwreckedRescueQuest.SetStage(0)
        Else
            RAS_ImpossibleToStartMessage.Show()
        EndIf
    EndIf
EndEvent

