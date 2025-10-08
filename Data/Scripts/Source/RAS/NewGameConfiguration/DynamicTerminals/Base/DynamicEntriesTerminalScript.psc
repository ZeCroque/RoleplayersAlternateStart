Scriptname RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript extends ObjectReference Conditional

Import RAS:NewGameConfiguration:DynamicTerminals:Base:EntryStruct

TerminalMenu Property MainTerminalMenu Mandatory Const Auto
Int Property MainTerminalIdOffset Mandatory Const Auto

TerminalMenu Property TerminalSubmenu Mandatory Const Auto
Int Property TerminalSubmenuIdOffset Mandatory Const Auto

Keyword Property RAS_SubmenuEntryKeyword Mandatory Const Auto
MiscObject Property RAS_DynamicEntry_Base_None Mandatory Const Auto

FormList Property EntriesLists Mandatory Const Auto
MiscObject Property DefaultEntry Mandatory Const Auto
Form Property DefaultTextReplacement Mandatory Const Auto

Quest Property RAS_NewGameManagerQuest Mandatory Const Auto
Message Property RAS_SelectionInvalidatedMessage Mandatory Const Auto

MiscObject CurrentFragment
Form CurrentTextReplacement
Bool Property HasValidSelection Auto Conditional Hidden
Int Property SelectedEntryIndex Auto Conditional Hidden

CustomEvent SelectedFragmentTriggered
CustomEvent EntryTriggered
CustomEvent SubmenuTriggered
CustomEvent SelectionChanged

Entry[] Entries

Event OnCellLoad()
    Self.RegisterForRemoteEvent(MainTerminalMenu, "OnTerminalMenuItemRun")

    Int i = 0
    Int totalSize = 0
    Form[] entriesListsArray = EntriesLists.GetArray()
    While(i < entriesListsArray.Length)
        totalSize += (entriesListsArray[i] as RAS:NewGameConfiguration:DynamicTerminals:Base:EntriesListScript).EntriesList.Length
        i += 1
    EndWhile

    Entries = new Entry[totalSize]
    i = 0
    Int j
    Int lastIndex = 0
    While(i < entriesListsArray.Length)
        j = 0
        RAS:NewGameConfiguration:DynamicTerminals:Base:EntriesListScript entriesListScript = entriesListsArray[i] as RAS:NewGameConfiguration:DynamicTerminals:Base:EntriesListScript
        While(j < entriesListScript.EntriesList.Length)
            Int entryIndex = lastIndex + j
            Entries[entryIndex] = entriesListScript.EntriesList[j]
            If(Entries[entryIndex].Index)
                Entries[entryIndex].Index.SetValueInt(entryIndex)
            EndIf
            j += 1
        EndWhile
        lastIndex = j
        i += 1
    EndWhile

    ChangeSelection(DefaultEntry, DefaultTextReplacement, False)
    UpdateTerminalList(Entries, False)
    UpdateTerminalBodies()

    Self.RegisterForCustomEvent(RAS_NewGameManagerQuest as RAS:NewGameManagerQuest:NewGameManagerQuestScript, "ConfigurationChanged")
EndEvent

Event TerminalMenu.OnTerminalMenuItemRun(TerminalMenu akSender, int auiMenuItemID, TerminalMenu akTerminalBase, ObjectReference akTerminalRef)
    If(akTerminalBase == MainTerminalMenu)
        Int index = auiMenuItemID - MainTerminalIdOffset
        If(index < Entries.Length)
            var[] eventParams = new var[1]
            eventParams[0] = Entries[index].Fragment
            If(Entries[index].Fragment.HasKeyword(RAS_SubmenuEntryKeyword))
                Self.SendCustomEvent("SubmenuTriggered", eventParams)
                Self.RegisterForRemoteEvent(TerminalSubmenu, "OnTerminalMenuItemRun")
                UpdateTerminalBody(TerminalSubmenu)
            Else
                ChangeSelection(Entries[index].Fragment as MiscObject, Entries[index].Fragment)
                Self.SendCustomEvent("EntryTriggered", eventParams)
            EndIf
        EndIf
    EndIf
EndEvent

Function UpdateTerminalList(Entry[] array, Bool isSubMenu = True)
    Int idOffset = MainTerminalIdOffset
    TerminalMenu targetMenu = MainTerminalMenu
    If(isSubMenu)
        idOffset = TerminalSubmenuIdOffset
        targetMenu = TerminalSubmenu
    EndIf

    targetMenu.ClearDynamicMenuItems(Self)
    Int i = 0
    While(i < array.Length)
        If(!array[i].Condition || array[i].Condition.IsTrue() == !array[i].NegateCondition)
            Form[] tagReplacements = new Form[1]
            tagReplacements[0] = array[i].Fragment
            targetMenu.AddDynamicMenuItem(Self, array[i].Fragment.HasKeyword(RAS_SubmenuEntryKeyword) as Int, i + idOffset, tagReplacements)
        ElseIf(CurrentFragment == array[i].Fragment)
            (RAS_NewGameManagerQuest as RAS:NewGameManagerQuest:NewGameManagerQuestScript).InvalidatedTerminal.ForceRefTo(Self)
            RAS_SelectionInvalidatedMessage.Show()
            ChangeSelection(DefaultEntry, DefaultTextReplacement, True)
        EndIf
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

Function ChangeSelection(MiscObject akFragment, Form akTextSelection, Bool notify = True)
    CurrentFragment = akFragment
    CurrentTextReplacement = akTextSelection
    UpdateTerminalBodies()

    HasValidSelection = CurrentFragment != RAS_DynamicEntry_Base_None

    SelectedEntryIndex = -1
    Int i = 0
    While(i < Entries.Length)
        If(Entries[i].Fragment == akFragment)
            SelectedEntryIndex = i
            i = Entries.Length
        EndIf
        i += 1
    EndWhile

    If(notify)
        Self.SendCustomEvent("SelectionChanged")
    EndIf
EndFunction

Function CallSelectedFragment()
    If(HasValidSelection)
        var[] eventParams = new var[1]
        eventParams[0] = CurrentFragment
        Self.SendCustomEvent("SelectedFragmentTriggered", eventParams)
    EndIf
EndFunction

Event RAS:NewGameManagerQuest:NewGameManagerQuestScript.ConfigurationChanged(RAS:NewGameManagerQuest:NewGameManagerQuestScript akSender, var[] akArgs)
    UpdateTerminalList(Entries, False)
EndEvent