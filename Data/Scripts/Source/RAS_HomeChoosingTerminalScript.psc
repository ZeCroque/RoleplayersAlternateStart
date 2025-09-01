Scriptname RAS_HomeChoosingTerminalScript extends ObjectReference

ObjectReference Property RAS_HomeChoosingTerminalREF Mandatory Const Auto

Event OnCellLoad()
    PlayAnimation("Deploy")
EndEvent

Event OnActivate(ObjectReference akActionRef)
    RAS_HomeChoosingTerminalREF.Activate(akActionRef)
EndEvent