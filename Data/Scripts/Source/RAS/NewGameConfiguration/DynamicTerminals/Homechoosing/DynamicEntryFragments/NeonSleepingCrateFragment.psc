Scriptname RAS:NewGameConfiguration:DynamicTerminals:HomeChoosing:DynamicEntryFragments:NeonSleepingCrateFragment extends Form Const

ObjectReference Property RAS_HomeChoosingTerminalREF Mandatory Const Auto
Quest Property DialogueFCNeon Mandatory Const Auto

Event OnInit()
    RegisterForCustomEvent(RAS_HomeChoosingTerminalREF as RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript, "SelectedFragmentTriggered")
EndEvent

Event RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript.SelectedFragmentTriggered(RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript akSender, var[] kArgs)
    If(kArgs[0] as Form == Self)
        DialogueFCNeon.SetStage(620)
    Endif
EndEvent