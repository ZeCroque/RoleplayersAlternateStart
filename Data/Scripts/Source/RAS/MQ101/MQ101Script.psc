Scriptname RAS:MQ101:MQ101Script extends Quest

ReferenceAlias Property ConstellationInvite Mandatory Const Auto
ReferenceAlias Property Vasco Mandatory Const Auto
ObjectReference Property NewAtlantisToLodgeDoorREF Mandatory Const Auto
ObjectReference Property MQ204_NA_HunterMarker Mandatory Const Auto
Scene Property RAS_MQ101_VascoOutsideLodge Auto Const Mandatory
ObjectReference Property MQ101SetStage1510Trigger Mandatory Const Auto
ObjectReference Property MQ101SetStage1600Trigger Mandatory Const Auto
Static Property XMarker Mandatory Const Auto
Scene Property RAS_MQ401_001_LodgeIntro Auto Const

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

Event OnQuestStarted()
    Self.RegisterForRemoteEvent(NewAtlantisToLodgeDoorREF, "OnCellLoad")

    (GetAlias(7) as ReferenceAlias).ForceRefTo(MQ101SetStage1510Trigger.PlaceAtMe(XMarker))
    MQ101SetStage1510Trigger.Disable()

    Self.RegisterForDistanceLessThanEvent((GetAlias(8) as ReferenceAlias).GetReference(), Game.GetPlayer(), 5)

    MQ101SetStage1600Trigger.Disable()
    Self.RegisterForRemoteEvent(MQ101SetStage1600Trigger, "OnCellLoad")
EndEvent

Event OnDistanceLessThan(ObjectReference akObj1, ObjectReference akObj2, float afDistance, int aiEventID)
    If(GetStageDone(20)) ;If its the non-starborn variant
        SetStage(1600)
    Else
        RAS_MQ401_001_LodgeIntro.Start()
    EndIf
    UnregisterForDistanceEvents(akObj1, akObj2)
EndEvent

Event ObjectReference.OnCellLoad(ObjectReference akSender)
    If(akSender == NewAtlantisToLodgeDoorREF)
        MQ101SetStage1500TriggerREF = Game.GetFormFromFile(0x110654, "Starfield.esm") as ObjectReference
        Self.RegisterForRemoteEvent(MQ101SetStage1500TriggerREF, "OnTriggerEnter")

        Self.UnregisterForRemoteEvent(NewAtlantisToLodgeDoorREF, "OnCellLoad")
    ElseIf(akSender == MQ101SetStage1600Trigger)
        (Game.GetFormFromFile(0x4E715, "Starfield.esm") as ObjectReference).Disable()
        (Game.GetFormFromFile(0x4E716, "Starfield.esm") as ObjectReference).Disable()

        Self.UnregisterForRemoteEvent(MQ101SetStage1600Trigger, "OnCellLoad")
    EndIf
EndEvent

Event ObjectReference.OnTriggerEnter(ObjectReference akSender, ObjectReference akActionRef)
    if(akActionRef == Game.GetPlayer() && GetStage() >= 10 && GetStage() < 25)
        SetStage(20)
        RAS_MQ101_VascoOutsideLodge.Start()
        Self.UnregisterForRemoteEvent(MQ101SetStage1500TriggerREF, "OnTriggerEnter")
    EndIf
EndEvent