Scriptname RAS_GameStartCellTriggerScript extends ObjectReference Const

Quest Property RAS_NewGameManagerQuest Mandatory Const Auto

Event OnTriggerEnter(ObjectReference akActionRef)
    Game.HideHudMenus()
    RAS_NewGameManagerQuest.SetStage(5)
EndEvent