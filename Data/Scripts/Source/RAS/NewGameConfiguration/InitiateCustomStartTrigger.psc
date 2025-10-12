Scriptname RAS:NewGameConfiguration:InitiateCustomStartTrigger extends ObjectReference

Message Property RAS_ConfirmStartMessage Mandatory Const Auto
ObjectReference Property RAS_StartingLocationTerminalREF Mandatory Const Auto
ConditionForm Property RAS_PlayerSelectedRandomStart Mandatory Const Auto
ObjectReference Property RAS_ShipServicesActorREF Mandatory Const Auto
Message Property RAS_RandomStartWarning Mandatory Const Auto

Bool TimerRunning

Event OnTriggerEnter(ObjectReference akActionRef)
    If(!TimerRunning)
        TimerRunning = True
        Self.StartTimer(2)

        If(RAS_ConfirmStartMessage.Show())
            If(RAS_PlayerSelectedRandomStart.IsTrue() && (RAS_ShipServicesActorREF as RAS:NewGameConfiguration:ShipVendorScript).NoShipSelected)
                If(!RAS_RandomStartWarning.Show())
                    Return
                EndIf
            EndIf

            Game.RequestSave()
            
            ;Move player to its destination
            (RAS_StartingLocationTerminalREF as RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript).CallSelectedFragment()
        EndIf
    EndIf
EndEvent

Event OnTimer(int aiTimerID)
    TimerRunning = False
EndEvent