Scriptname RAS:NewGameConfiguration:FactionsActivatorScript extends ObjectReference Const

Message Property RAS_FactionNotAvailableMessage Mandatory Const Auto

Event OnCellLoad()
    If(RAS:Utility:ModInfo.IsAchievementFriendly())
        Disable()
    EndIf
EndEvent

Event OnActivate(ObjectReference akActionRef)
    RAS_FactionNotAvailableMessage.Show()
EndEvent