Scriptname RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript extends ObjectReference Conditional

TerminalMenu Property MainTerminalMenu Mandatory Const Auto
Int Property MainTerminalIdOffset Mandatory Const Auto

TerminalMenu Property TerminalSubmenu Mandatory Const Auto
Int Property TerminalSubmenuIdOffset Mandatory Const Auto

Keyword Property RAS_SubmenuEntryKeyword Mandatory Const Auto
MiscObject Property RAS_DynamicEntry_Base_None Mandatory Const Auto

FormList Property Entries Mandatory Const Auto
MiscObject Property DefaultEntry Mandatory Const Auto
Form Property DefaultTextReplacement Mandatory Const Auto

MiscObject CurrentFragment
Form CurrentTextReplacement
Bool Property HasValidSelection Auto Conditional

CustomEvent SelectedFragmentTriggered
CustomEvent EntryTriggered
CustomEvent SubmenuTriggered

Event OnCellLoad()
    Self.RegisterForRemoteEvent(MainTerminalMenu, "OnTerminalMenuItemRun")

    ChangeSelection(DefaultEntry, DefaultTextReplacement)
EndEvent

Event OnActivate(ObjectReference akActionRef)
     UpdateTerminalBody(MainTerminalMenu)
     UpdateTerminalList(Entries.GetArray(), False)
EndEvent

Event TerminalMenu.OnTerminalMenuItemRun(TerminalMenu akSender, int auiMenuItemID, TerminalMenu akTerminalBase, ObjectReference akTerminalRef)
    If(akTerminalBase == MainTerminalMenu)
        Int index = auiMenuItemID - MainTerminalIdOffset
        Form[] entriesArray = Entries.GetArray()
        If(index < entriesArray.Length)
            var[] eventParams = new var[1]
            eventParams[0] = entriesArray[index]
            If(entriesArray[index].HasKeyword(RAS_SubmenuEntryKeyword))
                Self.SendCustomEvent("SubmenuTriggered", eventParams)
                Self.RegisterForRemoteEvent(TerminalSubmenu, "OnTerminalMenuItemRun")
                UpdateTerminalBody(TerminalSubmenu)
            Else
                ChangeSelection(entriesArray[index] as MiscObject, entriesArray[index])
                Self.SendCustomEvent("EntryTriggered", eventParams)
            EndIf
        EndIf
    EndIf
EndEvent

Function UpdateTerminalList(Form[] array, Bool isSubMenu = True)
    Int idOffset = MainTerminalIdOffset
    TerminalMenu targetMenu = MainTerminalMenu
    If(isSubMenu)
        idOffset = TerminalSubmenuIdOffset
        targetMenu = TerminalSubmenu
    EndIf

    targetMenu.ClearDynamicMenuItems(Self)
    Int i = 0
    While(i < array.Length)
        Form[] tagReplacements = new Form[1]
        tagReplacements[0] = array[i]
        targetMenu.AddDynamicMenuItem(Self, array[i].HasKeyword(RAS_SubmenuEntryKeyword) as Int, i + idOffset, tagReplacements)
        i = i + 1
    EndWhile
EndFunction

Function UpdateTerminalBodies()
    UpdateTerminalBody(MainTerminalMenu)
    UpdateTerminalBody(TerminalSubmenu)
EndFunction

Function UpdateTerminalBody(TerminalMenu akTerminalMenu)
    akTerminalMenu.ClearDynamicBodyTextItems(Self)
    Form[] tagReplacements = new Form[1]
    tagReplacements[0] = CurrentTextReplacement
    akTerminalMenu.AddDynamicBodyTextItem(Self, 0, 0, tagReplacements)
EndFunction

Function ChangeSelection(MiscObject akFragment, Form akTextSelection)
    CurrentFragment = akFragment
    CurrentTextReplacement = akTextSelection
    UpdateTerminalBodies()

    HasValidSelection = CurrentFragment != RAS_DynamicEntry_Base_None
EndFunction

Function CallSelectedFragment()
    If(HasValidSelection)
        var[] eventParams = new var[1]
        eventParams[0] = CurrentFragment
        Self.SendCustomEvent("SelectedFragmentTriggered", eventParams)
    EndIf
EndFunction