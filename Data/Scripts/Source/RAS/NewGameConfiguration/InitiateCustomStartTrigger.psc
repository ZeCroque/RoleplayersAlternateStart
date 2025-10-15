Scriptname RAS:NewGameConfiguration:InitiateCustomStartTrigger extends ObjectReference

Message Property RAS_ConfirmStartMessage Mandatory Const Auto
ObjectReference Property RAS_StartingLocationTerminalREF Mandatory Const Auto
ConditionForm Property RAS_PlayerSelectedRandomStart Mandatory Const Auto
ObjectReference Property RAS_ShipServicesActorREF Mandatory Const Auto
Message Property RAS_RandomStartWarning Mandatory Const Auto
GlobalVariable Property RAS_DynamicTerminalIndex_Start_Starstation Mandatory Const Auto
Message Property RAS_StarstationStartWarning Mandatory Const Auto
Quest Property RAS_BrokenShipQuest Mandatory Const Auto
Message Property RAS_BrokenShipWarning Mandatory Const Auto

Bool TimerRunning

Event OnTriggerEnter(ObjectReference akActionRef)
    If(!TimerRunning)
        TimerRunning = True
        Self.StartTimer(2)

        RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript startingLocationTerminal = RAS_StartingLocationTerminalREF as RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript 

        If(RAS_ConfirmStartMessage.Show())
            If((RAS_ShipServicesActorREF as RAS:NewGameConfiguration:ShipVendorScript).NoShipSelected)
                If(RAS_PlayerSelectedRandomStart.IsTrue())
                    If(!RAS_RandomStartWarning.Show())
                        Return
                    EndIf
                ElseIf(startingLocationTerminal.SelectedEntryIndex == RAS_DynamicTerminalIndex_Start_Starstation.GetValueInt())
                    If(!RAS_StarstationStartWarning.Show())
                        Return
                    EndIf
                EndIf
            ElseIf((RAS_BrokenShipQuest as RAS:BrokenShipQuest:BrokenShipQuestScript).IsEnabled && startingLocationTerminal.SelectedEntryIndex == RAS_DynamicTerminalIndex_Start_Starstation.GetValueInt())
                If(!RAS_BrokenShipWarning.Show())
                    Return
                EndIf
            EndIf

            Game.RequestSave()
            
            ;Move player to its destination
            startingLocationTerminal.CallSelectedFragment()
        EndIf
    EndIf
EndEvent

Event OnTimer(int aiTimerID)
    TimerRunning = False
EndEvent