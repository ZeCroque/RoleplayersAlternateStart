Scriptname RAS:NewGameConfiguration:DynamicTerminals:NarrativeAdjustments:NarrativeAdjustmentsActivatorScript extends ObjectReference

Import RAS:NewGameConfiguration:DynamicTerminals:NarrativeAdjustments:NarrativeModStruct

ObjectReference Property RAS_NarrativeAdjustmentsTerminalREF Mandatory Const Auto

MiscObject Property RAS_DynamicEntry_NA_Enable Mandatory Const Auto
MiscObject Property RAS_DynamicEntry_NA_Disable Mandatory Const Auto
TerminalMenu Property RAS_NarrativeAdjustmentsTerminalMenu Mandatory Const Auto
TerminalMenu Property RAS_NarrativeAdjustmentsTerminal_Submenu Mandatory Const Auto
Quest Property RAS_NewGameManagerQuest Mandatory Const Auto
Message Property RAS_SelectionInvalidatedMessage Mandatory Const Auto
FormList Property RAS_NarrativeAdjustmentsList Mandatory Const Auto

CustomEvent SelectionChanged
CustomEvent FragmentTriggered

NarrativeMod[] NarrativeMods
MiscObject[] SelectedFragments
Int CurrentIndex = 0

Int[] MenuIdToNarrativeModIndex

Event OnCellLoad()
    Self.RegisterForRemoteEvent(RAS_NarrativeAdjustmentsTerminalMenu, "OnTerminalMenuItemRun")

    Int i = 0
    Int totalSize = 0
    Form[] narrativeModsListArray = RAS_NarrativeAdjustmentsList.GetArray()
    While(i < narrativeModsListArray.Length)
        totalSize += (narrativeModsListArray[i] as RAS:NewGameConfiguration:DynamicTerminals:NarrativeAdjustments:NarrativeModsListScript).NarrativeModsList.Length
        i += 1
    EndWhile

    NarrativeMods = new NarrativeMod[totalSize]
    SelectedFragments = new MiscObject[totalSize]
    i = 0
    Int j
    Int lastIndex = 0
    While(i < NarrativeMods.Length)
        j = 0
        RAS:NewGameConfiguration:DynamicTerminals:NarrativeAdjustments:NarrativeModsListScript narrativeModsListScript = narrativeModsListArray[i] as RAS:NewGameConfiguration:DynamicTerminals:NarrativeAdjustments:NarrativeModsListScript
        While(j < narrativeModsListScript.NarrativeModsList.Length)
            NarrativeMods[lastIndex + j] = narrativeModsListScript.NarrativeModsList[j]
            SelectedFragments[lastIndex + j] = RAS_DynamicEntry_NA_Disable
            j += 1
        EndWhile
        lastIndex = j
        i += 1
    EndWhile
    
    UpdateTerminalList()
    Self.RegisterForCustomEvent(RAS_NewGameManagerQuest as RAS:NewGameManagerQuest:NewGameManagerQuestScript, "ConfigurationChanged")
EndEvent

Event OnActivate(ObjectReference akActionRef) 
    RAS_NarrativeAdjustmentsTerminalREF.Activate(akActionRef)
EndEvent

Function UpdateTerminalList()
    MenuIdToNarrativeModIndex = new Int[NarrativeMods.Length]

    RAS_NarrativeAdjustmentsTerminalMenu.ClearDynamicMenuItems(RAS_NarrativeAdjustmentsTerminalREF)
    Int i = 0
    Int j = 0
    While(i < NarrativeMods.Length)
        If(!NarrativeMods[i].Condition || NarrativeMods[i].Condition.IsTrue() == !NarrativeMods[i].NegateCondition)
            MenuIdToNarrativeModIndex[j] = i

            Form[] tagReplacements = new Form[1]
            tagReplacements[0] = NarrativeMods[i].SubmenuEntry
            RAS_NarrativeAdjustmentsTerminalMenu.AddDynamicMenuItem(RAS_NarrativeAdjustmentsTerminalREF, 0, j + 1, tagReplacements)
            j += 1
        ElseIf(SelectedFragments[i] == RAS_DynamicEntry_NA_Enable)
            (RAS_NewGameManagerQuest as RAS:NewGameManagerQuest:NewGameManagerQuestScript).InvalidatedTerminal.ForceRefTo(RAS_NarrativeAdjustmentsTerminalREF)
            RAS_SelectionInvalidatedMessage.Show()
            SelectedFragments[i] = RAS_DynamicEntry_NA_Disable
        EndIf
        i += 1
    EndWhile
EndFunction

Event TerminalMenu.OnTerminalMenuItemRun(TerminalMenu akSender, int auiMenuItemID, TerminalMenu akTerminalBase, ObjectReference akTerminalRef)
    If(akTerminalBase == RAS_NarrativeAdjustmentsTerminalMenu)
        Int index = auiMenuItemID - 1
        If(index < NarrativeMods.Length)
            CurrentIndex = MenuIdToNarrativeModIndex[index]
            UpdateSubmenuBody()
        EndIf
    ElseIf(akTerminalBase == RAS_NarrativeAdjustmentsTerminal_Submenu)
        If(auiMenuItemID == 0)
            SelectedFragments[CurrentIndex] = RAS_DynamicEntry_NA_Disable
        ElseIf(auiMenuItemID == 1)
            SelectedFragments[CurrentIndex] = RAS_DynamicEntry_NA_Enable
        EndIf            
        UpdateSubmenuBody()
        Self.SendCustomEvent("SelectionChanged")
    EndIf
EndEvent

Function UpdateSubmenuBody()
    RAS_NarrativeAdjustmentsTerminal_Submenu.ClearDynamicBodyTextItems(RAS_NarrativeAdjustmentsTerminalREF)
    Form[] tagReplacements = new Form[2]
    tagReplacements[0] = NarrativeMods[CurrentIndex].TextBody
    tagReplacements[1] = SelectedFragments[CurrentIndex]
    RAS_NarrativeAdjustmentsTerminal_Submenu.AddDynamicBodyTextItem(RAS_NarrativeAdjustmentsTerminalREF, 0, 0, tagReplacements)
EndFunction

Function TriggerAllValidFragment()
    Int i = 0
    While(i < SelectedFragments.Length)
        If(SelectedFragments[i] == RAS_DynamicEntry_NA_Enable)
            var[] eventParams = new var[1]
            eventParams[0] = NarrativeMods[i].Fragment
            Self.SendCustomEvent("FragmentTriggered", eventParams)
        EndIf
        i += 1
    EndWhile
EndFunction

Event RAS:NewGameManagerQuest:NewGameManagerQuestScript.ConfigurationChanged(RAS:NewGameManagerQuest:NewGameManagerQuestScript akSender, var[] akArgs)
    UpdateTerminalList()
EndEvent