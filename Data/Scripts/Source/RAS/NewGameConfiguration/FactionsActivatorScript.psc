Scriptname RAS:NewGameConfiguration:FactionsActivatorScript extends ObjectReference Const

Message Property RAS_FactionNotAvailableMessage Mandatory Const Auto

Event OnActivate(ObjectReference akActionRef)
    RAS_FactionNotAvailableMessage.Show()
EndEvent