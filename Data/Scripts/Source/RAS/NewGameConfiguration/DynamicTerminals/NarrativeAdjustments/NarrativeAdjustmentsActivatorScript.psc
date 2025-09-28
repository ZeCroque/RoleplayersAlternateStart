Scriptname RAS:NewGameConfiguration:DynamicTerminals:NarrativeAdjustments:NarrativeAdjustmentsActivatorScript extends ObjectReference

ObjectReference Property RAS_NarrativeAdjustmentsTerminalREF Mandatory Const Auto

MiscObject Property RAS_DynamicEntry_NA_Enable Mandatory Const Auto
MiscObject Property RAS_DynamicEntry_NA_Disable Mandatory Const Auto
TerminalMenu Property RAS_NarrativeAdjustmentsTerminalMenu Mandatory Const Auto
TerminalMenu Property RAS_NarrativeAdjustmentsTerminal_Submenu Mandatory Const Auto

CustomEvent FragmentTriggered

Struct NarrativeMod
    MiscObject SubmenuEntry
    Message TextBody
    MiscObject Fragment
    ConditionForm Condition
EndStruct
NarrativeMod[] Property NarrativeMods Mandatory Const Auto
MiscObject[] SelectedFragments
Int CurrentIndex = 0

Int[] MenuIdToNarrativeModIndex

Event OnInit()
    SelectedFragments = new MiscObject[NarrativeMods.Length]
    Int i = 0
    While(i < NarrativeMods.Length)
        SelectedFragments[i] = RAS_DynamicEntry_NA_Disable
        i += 1
    EndWhile
EndEvent

Event OnCellLoad()
    Self.RegisterForRemoteEvent(RAS_NarrativeAdjustmentsTerminalMenu, "OnTerminalMenuItemRun")
EndEvent

Event OnActivate(ObjectReference akActionRef) 
    MenuIdToNarrativeModIndex = new Int[NarrativeMods.Length]

    RAS_NarrativeAdjustmentsTerminalMenu.ClearDynamicMenuItems(RAS_NarrativeAdjustmentsTerminalREF)
    Int i = 0
    Int j = 0
    While(i < NarrativeMods.Length)
        If(!NarrativeMods[i].Condition || NarrativeMods[i].Condition.IsTrue())
            MenuIdToNarrativeModIndex[j] = i

            Form[] tagReplacements = new Form[1]
            tagReplacements[0] = NarrativeMods[i].SubmenuEntry
            RAS_NarrativeAdjustmentsTerminalMenu.AddDynamicMenuItem(RAS_NarrativeAdjustmentsTerminalREF, 0, j + 1, tagReplacements)
            j += 1
        EndIf
        i += 1
    EndWhile

    RAS_NarrativeAdjustmentsTerminalREF.Activate(akActionRef)
EndEvent

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
            UpdateSubmenuBody()
        ElseIf(auiMenuItemID == 1)
            SelectedFragments[CurrentIndex] = RAS_DynamicEntry_NA_Enable
            UpdateSubmenuBody()
        EndIf
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