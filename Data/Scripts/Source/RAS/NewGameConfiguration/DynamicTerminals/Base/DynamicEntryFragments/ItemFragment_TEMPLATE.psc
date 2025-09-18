Scriptname RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntryFragments:ItemFragment_TEMPLATE extends MiscObject

ObjectReference Property DynamicTerminal Mandatory Const Auto

Event OnInit()
    RegisterForCustomEvent(DynamicTerminal as RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript, "SelectedFragmentTriggered")
EndEvent

Event RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript.SelectedFragmentTriggered(RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript akSender, var[] kArgs)
    If(kArgs[0] as Form == Self)
        ;Add your code here
    Endif
EndEvent