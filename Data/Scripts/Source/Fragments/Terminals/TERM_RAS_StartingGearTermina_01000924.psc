;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname Fragments:Terminals:TERM_RAS_StartingGearTermina_01000924 Extends TerminalMenu Hidden Const

;BEGIN FRAGMENT Fragment_TerminalMenu_00
Function Fragment_TerminalMenu_00(ObjectReference akTerminalRef)
;BEGIN CODE
RAS_CurrentBudget.SetValue(RAS_LowBudget.GetValue())
RAS_NewGameManagerQuest.UpdateCurrentInstanceGlobal(RAS_CurrentBudget)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_01
Function Fragment_TerminalMenu_01(ObjectReference akTerminalRef)
;BEGIN CODE
RAS_CurrentBudget.SetValue(RAS_MediumBudget.GetValue())
RAS_NewGameManagerQuest.UpdateCurrentInstanceGlobal(RAS_CurrentBudget)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_02
Function Fragment_TerminalMenu_02(ObjectReference akTerminalRef)
;BEGIN CODE
RAS_CurrentBudget.SetValue(RAS_HighBudget.GetValue())
RAS_NewGameManagerQuest.UpdateCurrentInstanceGlobal(RAS_CurrentBudget)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property RAS_CurrentBudget Auto Const Mandatory

GlobalVariable Property RAS_LowBudget Auto Const Mandatory

GlobalVariable Property RAS_MediumBudget Auto Const Mandatory

GlobalVariable Property RAS_HighBudget Auto Const Mandatory

Quest Property RAS_NewGameManagerQuest Auto Const Mandatory
