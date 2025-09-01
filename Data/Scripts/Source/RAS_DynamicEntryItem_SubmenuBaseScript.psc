Scriptname RAS_DynamicEntryItem_SubmenuBaseScript extends MiscObject

ObjectReference Property DynamicTerminal Mandatory Const Auto
TerminalMenu Property TerminalSubmenu Mandatory Const Auto

Event OnInit()
    Self.RegisterForCustomEvent(DynamicTerminal as RAS_DynamicEntriesTerminalScript, "SubmenuTriggered")
EndEvent

Event RAS_DynamicEntriesTerminalScript.SubmenuTriggered(RAS_DynamicEntriesTerminalScript akSender, var[] kArgs)
    If(kArgs[0] as Form == Self)
        Self.RegisterForRemoteEvent(TerminalSubmenu, "OnTerminalMenuItemRun")
         ;You can dynamically add your entries here with (DynamicTerminal as RAS_DynamicEntriesTerminalScript).UpdateTerminalList(myArray)
    Else
        Self.UnregisterForRemoteEvent(TerminalSubmenu, "OnTerminalMenuItemRun")
    Endif
EndEvent

Event TerminalMenu.OnTerminalMenuItemRun(TerminalMenu akSender, int auiMenuItemID, TerminalMenu akTerminalBase, ObjectReference akTerminalRef)
    ;Handle item selection here. e.g: set "(DynamicTerminal as RAS_DynamicEntriesTerminalScript).CurrentSelection" to smth)
    ;Note that you will need to remove 1 to auiMenuItemID (or more if you manually added entries)
EndEvent