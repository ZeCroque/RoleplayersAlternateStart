Scriptname RAS_HomeChoosingTerminalScript extends ObjectReference

FormList Property RAS_HomesList Mandatory Const Auto
TerminalMenu Property RAS_HomeChoosingTerminalMenu Mandatory Const Auto
ObjectReference Property RAS_HomeChoosingTerminalREF Mandatory Const Auto
MiscObject Property RAS_NoneHome Mandatory Const Auto

CustomEvent HomeChosen

MiscObject Property CurrentHome  Auto

Form[] homes = None

Event OnCellLoad()
    PlayAnimation("Deploy")
    Self.RegisterForRemoteEvent(RAS_HomeChoosingTerminalMenu, "OnTerminalMenuItemRun")
    CurrentHome = RAS_NoneHome
EndEvent

Event OnActivate(ObjectReference akActionRef)
    RAS_HomeChoosingTerminalMenu.ClearDynamicMenuItems(RAS_HomeChoosingTerminalREF)
    homes = RAS_HomesList.GetArray()
    Int i = 0
    While(i < homes.Length)
        Form[] tagReplacements = new Form[1]
        tagReplacements[0] = homes[i]
        RAS_HomeChoosingTerminalMenu.AddDynamicMenuItem(RAS_HomeChoosingTerminalREF, 1, i + 2, tagReplacements)
        i = i + 1
    EndWhile

    UpdateTerminalBody()

    RAS_HomeChoosingTerminalREF.Activate(akActionRef)
EndEvent

Event TerminalMenu.OnTerminalMenuItemRun(TerminalMenu akSender, int auiMenuItemID, TerminalMenu akTerminalBase, ObjectReference akTerminalRef)
    If(auiMenuItemID == 1)
        CurrentHome = RAS_NoneHome

        UpdateTerminalBody()
    Else
        Int index = auiMenuItemID - 2
        If(index < homes.Length)
            CurrentHome = homes[index] as MiscObject

            UpdateTerminalBody()
        EndIf
    EndIf
EndEvent

Function UpdateTerminalBody()
    RAS_HomeChoosingTerminalMenu.ClearDynamicBodyTextItems(RAS_HomeChoosingTerminalREF)
    Form[] tagReplacements = new Form[1]
    tagReplacements[0] = CurrentHome
    RAS_HomeChoosingTerminalMenu.AddDynamicBodyTextItem(RAS_HomeChoosingTerminalREF, 0, 0, tagReplacements)
EndFunction

Function AcquireSelectedHome()
    If(CurrentHome != RAS_NoneHome)
        var[] eventParams = new var[1]
        eventParams[0] = CurrentHome
        Self.SendCustomEvent("HomeChosen", eventParams)
    EndIf
EndFunction