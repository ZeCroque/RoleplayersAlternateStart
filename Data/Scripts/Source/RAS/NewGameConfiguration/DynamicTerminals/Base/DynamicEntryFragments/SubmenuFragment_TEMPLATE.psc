Scriptname RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntryFragments:SubmenuFragment_TEMPLATE extends MiscObject

ObjectReference Property DynamicTerminal Mandatory Const Auto
TerminalMenu Property TerminalSubmenu Mandatory Const Auto

Event OnInit()
    Self.RegisterForCustomEvent(DynamicTerminal as RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript, "SubmenuTriggered")
EndEvent

Event RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript.SubmenuTriggered(RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript akSender, var[] kArgs)
    If(kArgs[0] as Form == Self)
        Self.RegisterForRemoteEvent(TerminalSubmenu, "OnTerminalMenuItemRun")
         ;You can dynamically add your entries here with (DynamicTerminal as RAS_DynamicEntriesTerminalScript).UpdateTerminalList(myArray)
    Else
        Self.UnregisterForRemoteEvent(TerminalSubmenu, "OnTerminalMenuItemRun")
    Endif
EndEvent

Event TerminalMenu.OnTerminalMenuItemRun(TerminalMenu akSender, int auiMenuItemID, TerminalMenu akTerminalBase, ObjectReference akTerminalRef)
    ;Handle item selection here. e.g: call "(DynamicTerminal as RAS_DynamicEntriesTerminalScript).ChangeSelection")
    ;Note that you will need to remove 1 to auiMenuItemID (or more if you manually added entries)
EndEvent