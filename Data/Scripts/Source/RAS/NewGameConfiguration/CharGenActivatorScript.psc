Scriptname RAS:NewGameConfiguration:CharGenActivatorScript extends ObjectReference Const

Event OnActivate(ObjectReference akActionRef)
    Game.ShowRaceMenu(uiMode=2) 
EndEvent