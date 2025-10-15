Scriptname RAS:NewGameConfiguration:DynamicTerminals:HomeChoosing:DynamicEntryFragments:NewAtlantisWellFragment extends Form Const

ObjectReference Property RAS_HomeChoosingTerminalREF Mandatory Const Auto
Quest Property DialogueUCNewAtlantis Mandatory Const Auto
MiscObject Property RAS_DynamicEntry_Start_AtHome Mandatory Const Auto
GlobalVariable Property UC05_PlayerIsUCCitizen Mandatory Const Auto
Quest Property UC_NA_Home_Well_Misc Mandatory Const Auto
ObjectReference Property OutpostWellPlayerHouse_Ref Mandatory Const Auto
ObjectReference Property RAS_StartingLocationTerminalREF Mandatory Const Auto
GlobalVariable Property RAS_DynamicTerminalIndex_Start_AtHome Mandatory Const Auto

Event OnInit()
    RegisterForCustomEvent(RAS_HomeChoosingTerminalREF as RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript, "SelectedFragmentTriggered")
    RegisterForCustomEvent(RAS_HomeChoosingTerminalREF as RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript, "EntryTriggered")
EndEvent

Event RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript.EntryTriggered(RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript akSender, var[] kArgs)
    If(kArgs[0] as Form == Self)
        Self.RegisterForRemoteEvent(Game.GetPlayer(), "OnLocationChange")
        RAS:NewGameConfiguration:DynamicTerminals:StartingLocation:DynamicEntryFragments:HouseFragment houseFragment = RAS_DynamicEntry_Start_AtHome as RAS:NewGameConfiguration:DynamicTerminals:StartingLocation:DynamicEntryFragments:HouseFragment
        houseFragment.TargetReference = OutpostWellPlayerHouse_Ref
        houseFragment.DirectionQuest = UC_NA_Home_Well_Misc
        houseFragment.DirectionQuestStage = 1000
    Else
        Self.UnregisterForRemoteEvent(Game.GetPlayer(), "OnLocationChange")        
    Endif
EndEvent

Event RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript.SelectedFragmentTriggered(RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript akSender, var[] kArgs)
    If(kArgs[0] as Form == Self)
        UC05_PlayerIsUCCitizen.SetValueInt(1)
        DialogueUCNewAtlantis.SetStage(364)
    Endif
EndEvent        

Event Actor.OnLocationChange(Actor akSender, Location akOldLoc, Location akNewLoc)
    If((RAS_StartingLocationTerminalREF as RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript).SelectedEntryIndex == RAS_DynamicTerminalIndex_Start_AtHome.GetValueInt())
        Game.GetPlayer().MoveTo(Game.GetForm(0xEEFB4) as ObjectReference)
    Endif
    Self.UnregisterForRemoteEvent(Game.GetPlayer(), "OnLocationChange")
EndEvent
