Scriptname RAS:NewGameConfiguration:DynamicTerminals:HomeChoosing:DynamicEntryFragments:NeonSkySuiteFragment extends Form Const

ObjectReference Property RAS_HomeChoosingTerminalREF Mandatory Const Auto
Quest Property DialogueFCNeon Mandatory Const Auto
MiscObject Property RAS_DynamicEntry_Start_AtHome Mandatory Const Auto
ObjectReference Property OutpostPlayerHouseActivator Mandatory Const Auto
Quest Property DialogueFCNeon_PlayerHomeQuest Mandatory Const Auto

Event OnInit()
    RegisterForCustomEvent(RAS_HomeChoosingTerminalREF as RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript, "SelectedFragmentTriggered")
    RegisterForCustomEvent(RAS_HomeChoosingTerminalREF as RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript, "EntryTriggered")
EndEvent

Event RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript.EntryTriggered(RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript akSender, var[] kArgs)
    If(kArgs[0] as Form == Self)
        (RAS_DynamicEntry_Start_AtHome as RAS:NewGameConfiguration:DynamicTerminals:StartingLocation:DynamicEntryFragments:DefaultMoveToRefFragment).TargetReference = OutpostPlayerHouseActivator
    Endif
EndEvent

Event RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript.SelectedFragmentTriggered(RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript akSender, var[] kArgs)
    If(kArgs[0] as Form == Self)
        DialogueFCNeon.SetStage(101)
        DialogueFCNeon_PlayerHomeQuest.SetStage(40)
    Endif
EndEvent