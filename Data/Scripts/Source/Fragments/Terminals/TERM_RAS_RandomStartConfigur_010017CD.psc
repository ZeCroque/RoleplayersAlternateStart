;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname Fragments:Terminals:TERM_RAS_RandomStartConfigur_010017CD Extends TerminalMenu Hidden Const

;BEGIN FRAGMENT Fragment_TerminalMenu_01
Function Fragment_TerminalMenu_01(ObjectReference akTerminalRef)
;BEGIN CODE
RAS_LocationUseCustomLevelRange.SetValue(0)

ObjectReference currentTerminal = TerminalMenu.GetCurrentTerminalObjectRef()    
Self.ClearDynamicBodyTextItems(currentTerminal)
Form[] tagReplacements = new Form[1]
tagReplacements[0] = RAS_LocationLevelEntry_Default
Self.AddDynamicBodyTextItem(currentTerminal, 0, 0, tagReplacements)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_02
Function Fragment_TerminalMenu_02(ObjectReference akTerminalRef)
;BEGIN CODE
RAS_LocationUseCustomLevelRange.SetValue(1)

RAS_LocationUseCustomLevelRange.SetValue(0)

ObjectReference currentTerminal = TerminalMenu.GetCurrentTerminalObjectRef()    
Self.ClearDynamicBodyTextItems(currentTerminal)
Form[] tagReplacements = new Form[1]
tagReplacements[0] = RAS_LocationLevelEntry_Custom
Self.AddDynamicBodyTextItem(currentTerminal, 0, 0, tagReplacements)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property RAS_LocationUseCustomLevelRange Auto Const Mandatory

Message Property RAS_LocationLevelEntry_Default Auto Const Mandatory

Message Property RAS_LocationLevelEntry_Custom Auto Const Mandatory
