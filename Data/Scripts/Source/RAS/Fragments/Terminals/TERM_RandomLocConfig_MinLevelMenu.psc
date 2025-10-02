;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname RAS:Fragments:Terminals:TERM_RandomLocConfig_MinLevelMenu Extends TerminalMenu Hidden Const

;BEGIN FRAGMENT Fragment_TerminalMenu_00
Function Fragment_TerminalMenu_00(ObjectReference akTerminalRef)
;BEGIN CODE
RAS_LocationMinLevel.SetValue(1)
RAS_LocationSpawnPointFinderQuest.UpdateCurrentInstanceGlobal(RAS_LocationMinLevel)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_01
Function Fragment_TerminalMenu_01(ObjectReference akTerminalRef)
;BEGIN CODE
RAS_LocationMinLevel.SetValue(10)
RAS_LocationSpawnPointFinderQuest.UpdateCurrentInstanceGlobal(RAS_LocationMinLevel)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_02
Function Fragment_TerminalMenu_02(ObjectReference akTerminalRef)
;BEGIN CODE
RAS_LocationMinLevel.SetValue(25)
RAS_LocationSpawnPointFinderQuest.UpdateCurrentInstanceGlobal(RAS_LocationMinLevel)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_03
Function Fragment_TerminalMenu_03(ObjectReference akTerminalRef)
;BEGIN CODE
RAS_LocationMinLevel.SetValue(50)
RAS_LocationSpawnPointFinderQuest.UpdateCurrentInstanceGlobal(RAS_LocationMinLevel)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_04
Function Fragment_TerminalMenu_04(ObjectReference akTerminalRef)
;BEGIN CODE
RAS_LocationMinLevel.SetValue(70)
RAS_LocationSpawnPointFinderQuest.UpdateCurrentInstanceGlobal(RAS_LocationMinLevel)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property RAS_LocationMinLevel Auto Const Mandatory

Quest Property RAS_LocationSpawnPointFinderQuest Auto Const Mandatory
