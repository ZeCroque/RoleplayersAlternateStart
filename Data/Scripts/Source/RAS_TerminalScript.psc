Scriptname RAS_TerminalScript extends ReferenceAlias

TerminalMenu Property BarrettMessageMenu Mandatory Const Auto

Event OnTerminalMenuItemRun(int auiMenuItemID, TerminalMenu akTerminalBase, ObjectReference akTerminalRef)
    If(akTerminalBase == BarrettMessageMenu)
        GetOwningQuest().SetStage(100)
    EndIf
EndEvent