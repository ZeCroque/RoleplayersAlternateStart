Scriptname RAS_DefaultStart extends MiscObject

ObjectReference Property DynamicTerminal Mandatory Const Auto

Location Property TargetLocation  Auto

Event OnInit()
    RegisterForCustomEvent(DynamicTerminal as RAS_DynamicEntriesTerminalScript, "SelectedFragmentTriggered")
EndEvent

Event RAS_DynamicEntriesTerminalScript.SelectedFragmentTriggered(RAS_DynamicEntriesTerminalScript akSender, var[] kArgs)
    If(kArgs[0] as Form == Self)
        ;TODO do smth with the Location
        Debug.Trace(TargetLocation)
    Endif
EndEvent
