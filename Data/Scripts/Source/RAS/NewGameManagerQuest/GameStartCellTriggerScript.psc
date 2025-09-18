Scriptname RAS:NewGameManagerQuest:GameStartCellTriggerScript extends ObjectReference Const

Quest Property RAS_NewGameManagerQuest Mandatory Const Auto

Event OnCellLoad()
    Game.HideHudMenus()
    RAS_NewGameManagerQuest.SetStage(5)
EndEvent