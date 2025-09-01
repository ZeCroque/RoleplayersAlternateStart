Scriptname RAS_HomeTerminal_SleepingCrateScript extends Form Const

ObjectReference Property RAS_HomeChoosingTerminalREF Mandatory Const Auto
Quest Property DialogueFCNeon Mandatory Const Auto

Event OnInit()
    RegisterForCustomEvent(RAS_HomeChoosingTerminalREF as RAS_DynamicEntriesTerminalScript, "SelectedFragmentTriggered")
EndEvent

Event RAS_DynamicEntriesTerminalScript.SelectedFragmentTriggered(RAS_DynamicEntriesTerminalScript akSender, var[] kArgs)
    If(kArgs[0] as Form == Self)
        DialogueFCNeon.SetStage(620)
    Endif
EndEvent