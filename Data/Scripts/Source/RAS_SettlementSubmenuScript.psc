Scriptname RAS_SettlementSubmenuScript extends Form

ObjectReference Property DynamicTerminal Mandatory Const Auto
TerminalMenu Property TerminalSubmenu Mandatory Const Auto

ObjectReference Property RAS_StartingLocationActivator Mandatory Const Auto
MiscObject Property RAS_DynamicEntry_Start_Default Mandatory Const Auto

Form[] Settlements

Event OnInit()
    Self.RegisterForCustomEvent(DynamicTerminal as RAS_DynamicEntriesTerminalScript, "SubmenuTriggered")

    (RAS_StartingLocationActivator as RAS_StartingLocationActivatorScript).InitStarts()
    Settlements = (RAS_StartingLocationActivator as RAS_StartingLocationActivatorScript).RAS_SettlementsLocationList.GetArray()
EndEvent

Event RAS_DynamicEntriesTerminalScript.SubmenuTriggered(RAS_DynamicEntriesTerminalScript akSender, var[] kArgs)
    If(kArgs[0] as Form == Self)
        Self.RegisterForRemoteEvent(TerminalSubmenu, "OnTerminalMenuItemRun")
        (DynamicTerminal as RAS_DynamicEntriesTerminalScript).UpdateTerminalList(Settlements, True)
    Else
        Self.UnregisterForRemoteEvent(TerminalSubmenu, "OnTerminalMenuItemRun")
    Endif
EndEvent

Event TerminalMenu.OnTerminalMenuItemRun(TerminalMenu akSender, int auiMenuItemID, TerminalMenu akTerminalBase, ObjectReference akTerminalRef)
    If(akTerminalBase == TerminalSubmenu)
        Int index = auiMenuItemID - 1
        If(index < Settlements.Length)
            (DynamicTerminal as RAS_DynamicEntriesTerminalScript).CurrentFragment = RAS_DynamicEntry_Start_Default
            (DynamicTerminal as RAS_DynamicEntriesTerminalScript).CurrentTextReplacement = Settlements[auiMenuItemID - 1]
            (RAS_DynamicEntry_Start_Default as RAS_DefaultStart).TargetLocation = Settlements[auiMenuItemID - 1] as Location
            (DynamicTerminal as RAS_DynamicEntriesTerminalScript).UpdateTerminalBodies()
        EndIf
    EndIf
EndEvent