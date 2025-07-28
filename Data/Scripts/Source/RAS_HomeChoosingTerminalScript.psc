Scriptname RAS_HomeChoosingTerminalScript extends ObjectReference

FormList Property RAS_HomesList Mandatory Const Auto
TerminalMenu Property RAS_HomeChoosingTerminalMenu Mandatory Const Auto

CustomEvent HomeChosen

Form[] homes = None

Event OnCellLoad()
    Self.RegisterForRemoteEvent(RAS_HomeChoosingTerminalMenu, "OnTerminalMenuItemRun")
    
    homes = RAS_HomesList.GetArray()
    Int i = 0
    While(i < homes.Length)
        Form[] tagReplacements = new Form[1]
        tagReplacements[0] = homes[i]
        RAS_HomeChoosingTerminalMenu.AddDynamicMenuItem(Self, 1, i + 2, tagReplacements)
        i = i + 1
    EndWhile
EndEvent

Event TerminalMenu.OnTerminalMenuItemRun(TerminalMenu akSender, int auiMenuItemID, TerminalMenu akTerminalBase, ObjectReference akTerminalRef)
    If(auiMenuItemID == 1)
        Debug.Trace("None")
    Else
        var[] eventParams = new var[1]
        eventParams[0] = homes[auiMenuItemID - 2]
        Self.SendCustomEvent("HomeChosen", eventParams)
    EndIf
EndEvent