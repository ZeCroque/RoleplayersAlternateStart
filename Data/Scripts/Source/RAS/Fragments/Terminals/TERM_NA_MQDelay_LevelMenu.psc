;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname RAS:Fragments:Terminals:TERM_NA_MQDelay_LevelMenu Extends TerminalMenu Hidden Const

;BEGIN FRAGMENT Fragment_TerminalMenu_00
Function Fragment_TerminalMenu_00(ObjectReference akTerminalRef)
;BEGIN CODE
RAS_MQLevelThreshold.SetValue(1)
RAS_NewGameManagerQuest.UpdateCurrentInstanceGlobal(RAS_MQLevelThreshold)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_01
Function Fragment_TerminalMenu_01(ObjectReference akTerminalRef)
;BEGIN CODE
RAS_MQLevelThreshold.SetValue(5)
RAS_NewGameManagerQuest.UpdateCurrentInstanceGlobal(RAS_MQLevelThreshold)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_02
Function Fragment_TerminalMenu_02(ObjectReference akTerminalRef)
;BEGIN CODE
RAS_MQLevelThreshold.SetValue(10)
RAS_NewGameManagerQuest.UpdateCurrentInstanceGlobal(RAS_MQLevelThreshold)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_03
Function Fragment_TerminalMenu_03(ObjectReference akTerminalRef)
;BEGIN CODE
RAS_MQLevelThreshold.SetValue(25)
RAS_NewGameManagerQuest.UpdateCurrentInstanceGlobal(RAS_MQLevelThreshold)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_04
Function Fragment_TerminalMenu_04(ObjectReference akTerminalRef)
;BEGIN CODE
RAS_MQLevelThreshold.SetValue(50)
RAS_NewGameManagerQuest.UpdateCurrentInstanceGlobal(RAS_MQLevelThreshold)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property RAS_NewGameManagerQuest Auto Const Mandatory

GlobalVariable Property RAS_MQLevelThreshold Auto Const Mandatory
