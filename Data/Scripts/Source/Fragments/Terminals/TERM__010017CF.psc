;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname Fragments:Terminals:TERM__010017CF Extends TerminalMenu Hidden Const

;BEGIN FRAGMENT Fragment_TerminalMenu_00
Function Fragment_TerminalMenu_00(ObjectReference akTerminalRef)
;BEGIN CODE
RAS_LocationMaxLevel.SetValue(10)
RAS_LocationSpawnPointFinderQuest.UpdateCurrentInstanceGlobal(RAS_LocationMaxLevel)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_01
Function Fragment_TerminalMenu_01(ObjectReference akTerminalRef)
;BEGIN CODE
RAS_LocationMaxLevel.SetValue(25)
RAS_LocationSpawnPointFinderQuest.UpdateCurrentInstanceGlobal(RAS_LocationMaxLevel)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_02
Function Fragment_TerminalMenu_02(ObjectReference akTerminalRef)
;BEGIN CODE
RAS_LocationMaxLevel.SetValue(50)
RAS_LocationSpawnPointFinderQuest.UpdateCurrentInstanceGlobal(RAS_LocationMaxLevel)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_03
Function Fragment_TerminalMenu_03(ObjectReference akTerminalRef)
;BEGIN CODE
RAS_LocationMaxLevel.SetValue(70)
RAS_LocationSpawnPointFinderQuest.UpdateCurrentInstanceGlobal(RAS_LocationMaxLevel)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property RAS_LocationMaxLevel Auto Const Mandatory

Quest Property RAS_LocationSpawnPointFinderQuest Auto Const Mandatory
