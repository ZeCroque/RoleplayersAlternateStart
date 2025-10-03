Scriptname RAS:NewGameConfiguration:DynamicTerminals:StartingLocation:DynamicEntryFragments:StarstationSubmenuFragment extends Form

Import RAS:NewGameConfiguration:DynamicTerminals:Base:EntryStruct

ObjectReference Property DynamicTerminal Mandatory Const Auto
TerminalMenu Property TerminalSubmenu Mandatory Const Auto

ObjectReference Property RAS_StartingLocationActivator Mandatory Const Auto
MiscObject Property RAS_DynamicEntry_Start_Default Mandatory Const Auto

Entry[] Settlements

Event OnInit()

    Self.RegisterForCustomEvent(DynamicTerminal as RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript, "SubmenuTriggered")

    (RAS_StartingLocationActivator as RAS:NewGameConfiguration:DynamicTerminals:StartingLocation:StartingLocationActivatorScript).InitStarts()
    Form[] settlementsArray = (RAS_StartingLocationActivator as RAS:NewGameConfiguration:DynamicTerminals:StartingLocation:StartingLocationActivatorScript).RAS_SettlementsLocationList.GetArray()
    Settlements = new Entry[settlementsArray.Length]
    Int i = 0
    While i < Settlements.Length
        Settlements[i] = new Entry
        Settlements[i].Fragment = settlementsArray[i]
        i += 1
    EndWhile
EndEvent

Event RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript.SubmenuTriggered(RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript akSender, var[] kArgs)
    If(kArgs[0] as Form == Self)
        Self.RegisterForRemoteEvent(TerminalSubmenu, "OnTerminalMenuItemRun")
        (DynamicTerminal as RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript).UpdateTerminalList(Settlements, True)
    Else
        Self.UnregisterForRemoteEvent(TerminalSubmenu, "OnTerminalMenuItemRun")
    Endif
EndEvent

Event TerminalMenu.OnTerminalMenuItemRun(TerminalMenu akSender, int auiMenuItemID, TerminalMenu akTerminalBase, ObjectReference akTerminalRef)
    Int index = auiMenuItemID - 1
    If(index < Settlements.Length)
        (DynamicTerminal as RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript).ChangeSelection(RAS_DynamicEntry_Start_Default, Settlements[auiMenuItemID - 1].Fragment)
        (RAS_DynamicEntry_Start_Default as RAS:NewGameConfiguration:DynamicTerminals:StartingLocation:DynamicEntryFragments:DefaultMoveToLocFragment).TargetLocation = Settlements[auiMenuItemID - 1].Fragment as Location
    EndIf
EndEvent