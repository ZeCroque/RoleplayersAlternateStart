;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname RAS:Fragments:Terminals:TERM_StartingGear_RemoveBudgetMenu Extends TerminalMenu Hidden Const

;BEGIN FRAGMENT Fragment_TerminalMenu_00
Function Fragment_TerminalMenu_00(ObjectReference akTerminalRef)
;BEGIN CODE
RAS_CurrentBudget.SetValue(Math.Max(0, RAS_CurrentBudget.GetValue() - 500))
RAS_NewGameManagerQuest.UpdateCurrentInstanceGlobal(RAS_CurrentBudget)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_01
Function Fragment_TerminalMenu_01(ObjectReference akTerminalRef)
;BEGIN CODE
RAS_CurrentBudget.SetValue(Math.Max(0, RAS_CurrentBudget.GetValue() - 1000))
RAS_NewGameManagerQuest.UpdateCurrentInstanceGlobal(RAS_CurrentBudget)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_02
Function Fragment_TerminalMenu_02(ObjectReference akTerminalRef)
;BEGIN CODE
RAS_CurrentBudget.SetValue(Math.Max(0, RAS_CurrentBudget.GetValue() - 10000))
RAS_NewGameManagerQuest.UpdateCurrentInstanceGlobal(RAS_CurrentBudget)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_03
Function Fragment_TerminalMenu_03(ObjectReference akTerminalRef)
;BEGIN CODE
RAS_CurrentBudget.SetValue(Math.Max(0, RAS_CurrentBudget.GetValue() - 100000))
RAS_NewGameManagerQuest.UpdateCurrentInstanceGlobal(RAS_CurrentBudget)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property RAS_CurrentBudget Auto Const Mandatory

Quest Property RAS_NewGameManagerQuest Auto Const Mandatory
