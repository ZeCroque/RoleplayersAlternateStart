Scriptname RAS_InitiateCustomStartTrigger extends ObjectReference Const

Message Property RAS_ConfirmStartMessage Mandatory Const Auto
ObjectReference Property RAS_StartingLocationTerminalREF Mandatory Const Auto

Event OnTriggerEnter(ObjectReference akActionRef)
    If(RAS_ConfirmStartMessage.Show())
        ;Move player to its destination
		(RAS_StartingLocationTerminalREF as RAS_DynamicEntriesTerminalScript).CallSelectedFragment()
    EndIf
EndEvent