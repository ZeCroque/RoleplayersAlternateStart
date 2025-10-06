Scriptname RAS:NewGameConfiguration:DynamicTerminals:StartingLocation:StartingLocationActivatorScript extends ObjectReference

Location Property CityNewAtlantisLocation Mandatory Const Auto
MiscObject Property RAS_DynamicEntry_Start_Default Mandatory Const Auto
ObjectReference Property RAS_StartingLocationTerminalREF Mandatory Const Auto

Event OnCellLoad()    
    (RAS_DynamicEntry_Start_Default as RAS:NewGameConfiguration:DynamicTerminals:StartingLocation:DynamicEntryFragments:DefaultMoveToLocFragment).TargetLocation = CityNewAtlantisLocation
EndEvent

Event OnActivate(ObjectReference akActionRef)
    RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript startingLocationTerminal = (RAS_StartingLocationTerminalREF as RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript)
    startingLocationTerminal.Activate(Game.GetPlayer())
EndEvent