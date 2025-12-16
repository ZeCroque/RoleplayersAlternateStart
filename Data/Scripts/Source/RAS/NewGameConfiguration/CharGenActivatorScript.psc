Scriptname RAS:NewGameConfiguration:CharGenActivatorScript extends ObjectReference Const

ActorValue Property PlayerUnityTimesEntered Mandatory Const Auto

Event OnActivate(ObjectReference akActionRef)
    If(Game.GetPlayer().GetValueInt(PlayerUnityTimesEntered) == 0)
        Game.ShowRaceMenu(uiMode=2) 
    Else
        Game.ShowRaceMenu(uiMode=1)
    EndIf
EndEvent