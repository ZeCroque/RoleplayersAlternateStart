;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname RAS:Fragments:Terminals:TERM_StartingGear_MainMenu Extends TerminalMenu Hidden Const

;BEGIN FRAGMENT Fragment_TerminalMenu_01
Function Fragment_TerminalMenu_01(ObjectReference akTerminalRef)
;BEGIN CODE
(RAS_StartingGearTerminal as RAS_StartingGearTerminalScript).StartRegularShopping()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_02
Function Fragment_TerminalMenu_02(ObjectReference akTerminalRef)
;BEGIN CODE
(RAS_StartingGearTerminal as RAS_StartingGearTerminalScript).StartFreeShopping()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ObjectReference Property RAS_StartingGearTerminal Auto Const Mandatory
