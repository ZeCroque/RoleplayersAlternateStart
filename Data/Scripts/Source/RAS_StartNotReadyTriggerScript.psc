Scriptname RAS_StartNotReadyTriggerScript extends ObjectReference Const

Message Property RAS_StartNotReadyMessage Mandatory Const Auto

Event OnTriggerEnter(ObjectReference akActionRef)
    RAS_StartNotReadyMessage.Show()
EndEvent
