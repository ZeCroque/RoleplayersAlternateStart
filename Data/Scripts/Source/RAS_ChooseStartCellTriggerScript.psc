Scriptname RAS_ChooseStartCellTriggerScript extends ObjectReference Const

Quest Property RAS_NewGameManagerQuest Mandatory Const Auto
Keyword Property AnimArchetypePlayer Mandatory Const Auto

Event OnCellLoad()
    Game.SetCharGenHUDMode(0)
    Game.SetInChargen(False, False, False)
    RAS_NewGameManagerQuest.SetActive()
    Game.GetPlayer().ChangeAnimArchetype(AnimArchetypePlayer)
    Disable()
EndEvent
