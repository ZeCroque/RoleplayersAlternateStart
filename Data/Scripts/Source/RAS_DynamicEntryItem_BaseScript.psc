Scriptname RAS_DynamicEntryItem_BaseScript extends MiscObject

ObjectReference Property DynamicTerminal Mandatory Const Auto

Event OnInit()
    RegisterForCustomEvent(DynamicTerminal as RAS_DynamicEntriesTerminalScript, "SelectedFragmentTriggered")
EndEvent

Event RAS_DynamicEntriesTerminalScript.SelectedFragmentTriggered(RAS_DynamicEntriesTerminalScript akSender, var[] kArgs)
    If(kArgs[0] as Form == Self)
        ;Add your code here
    Endif
EndEvent