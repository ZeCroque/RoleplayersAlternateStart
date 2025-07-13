Scriptname RAS_ChooseStartCellTriggerScript extends ObjectReference Const

Quest Property RAS_NewGameManagerQuest Mandatory Const Auto
GlobalVariable Property ENV_AllowPlayerSuffocation Auto Const Mandatory
Keyword Property AnimArchetypePlayer Mandatory Const Auto

Event OnTriggerEnter(ObjectReference akActionRef)
    Game.SetCharGenHUDMode(0)
    Game.SetInChargen(False, False, False)
    ENV_AllowPlayerSuffocation.SetValue(1)
    RAS_NewGameManagerQuest.SetActive()
    Game.GetPlayer().ChangeAnimArchetype(AnimArchetypePlayer)
    Disable()
EndEvent
