Scriptname RAS_MQ101Script extends Quest

ReferenceAlias Property ConstellationInvite Mandatory Const Auto
ReferenceAlias Property PlayerAlias Mandatory Const Auto
ReferenceAlias Property Vasco Mandatory Const Auto
ObjectReference Property NewAtlantisToLodgeDoorREF Mandatory Const Auto
ObjectReference Property MQ204_NA_HunterMarker Mandatory Const Auto
Scene Property RAS_MQ101_VascoOutsideLodge Auto Const Mandatory

ObjectReference Property Artifact01REF Auto

ObjectReference MQ101SetStage1500TriggerREF
InputEnableLayer VSEnableLayer

Function MQ101DisablePlayerControls()
	VSEnableLayer = InputEnableLayer.Create()
	VSEnableLayer.DisablePlayerControls()
EndFunction

Function MQ101EnablePlayerControls()
	VSEnableLayer = None
EndFunction

Event OnQuestInit()
    Self.RegisterForRemoteEvent(NewAtlantisToLodgeDoorREF, "OnCellLoad")
EndEvent

Event ObjectReference.OnCellLoad(ObjectReference akSender)
    MQ101SetStage1500TriggerREF = Game.GetFormFromFile(0x110654, "Starfield.esm") as ObjectReference
    Self.RegisterForRemoteEvent(MQ101SetStage1500TriggerREF, "OnTriggerEnter")

    Self.UnregisterForRemoteEvent(NewAtlantisToLodgeDoorREF, "OnCellLoad")
EndEvent

Event ObjectReference.OnTriggerEnter(ObjectReference akSender, ObjectReference akActionRef)
    if(akActionRef == Game.GetPlayer() && GetStage() >= 10 && GetStage() < 25)
        SetStage(20)
        RAS_MQ101_VascoOutsideLodge.Start()
        Self.UnregisterForRemoteEvent(MQ101SetStage1500TriggerREF, "OnTriggerEnter")
    EndIf
EndEvent