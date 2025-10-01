;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname Fragments:Terminals:TERM_RAS_RandomStartConfigur_010017D1 Extends TerminalMenu Hidden Const

;BEGIN FRAGMENT Fragment_TerminalMenu_01
Function Fragment_TerminalMenu_01(ObjectReference akTerminalRef)
;BEGIN CODE
RAS_LocationHabitabilityLevel.SetValue(0)

ObjectReference currentTerminal = TerminalMenu.GetCurrentTerminalObjectRef()    
Self.ClearDynamicBodyTextItems(currentTerminal)
Form[] tagReplacements = new Form[1]
tagReplacements[0] = RAS_HabitabilityEntry_Any
Self.AddDynamicBodyTextItem(currentTerminal, 0, 0, tagReplacements)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_02
Function Fragment_TerminalMenu_02(ObjectReference akTerminalRef)
;BEGIN CODE
RAS_LocationHabitabilityLevel.SetValue(1)

ObjectReference currentTerminal = TerminalMenu.GetCurrentTerminalObjectRef()    
Self.ClearDynamicBodyTextItems(currentTerminal)
Form[] tagReplacements = new Form[1]
tagReplacements[0] = RAS_HabitabilityEntry_Low
Self.AddDynamicBodyTextItem(currentTerminal, 0, 0, tagReplacements)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_03
Function Fragment_TerminalMenu_03(ObjectReference akTerminalRef)
;BEGIN CODE
RAS_LocationHabitabilityLevel.SetValue(1)

ObjectReference currentTerminal = TerminalMenu.GetCurrentTerminalObjectRef()    
Self.ClearDynamicBodyTextItems(currentTerminal)
Form[] tagReplacements = new Form[1]
tagReplacements[0] = RAS_HabitabilityEntry_Medium
Self.AddDynamicBodyTextItem(currentTerminal, 0, 0, tagReplacements)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_04
Function Fragment_TerminalMenu_04(ObjectReference akTerminalRef)
;BEGIN CODE
RAS_LocationHabitabilityLevel.SetValue(2)

ObjectReference currentTerminal = TerminalMenu.GetCurrentTerminalObjectRef()    
Self.ClearDynamicBodyTextItems(currentTerminal)
Form[] tagReplacements = new Form[1]
tagReplacements[0] = RAS_HabitabilityEntry_High
Self.AddDynamicBodyTextItem(currentTerminal, 0, 0, tagReplacements)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property RAS_LocationHabitabilityLevel Auto Const Mandatory

Message Property RAS_HabitabilityEntry_Any Auto Const Mandatory

Message Property RAS_HabitabilityEntry_Low Auto Const Mandatory

Message Property RAS_HabitabilityEntry_Medium Auto Const Mandatory

Message Property RAS_HabitabilityEntry_High Auto Const Mandatory
