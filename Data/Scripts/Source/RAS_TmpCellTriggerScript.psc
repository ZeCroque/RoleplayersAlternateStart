Scriptname RAS_TmpCellTriggerScript extends ObjectReference Const

Quest Property RAS_NewGameManagerQuest Mandatory Const Auto
ObjectReference Property RAS_ChooseStartCellMarkerREF01 Mandatory Const Auto
ImageSpaceModifier Property StayBlack Mandatory Const Auto
ImageSpaceModifier Property FadeFromBlack Mandatory Const Auto
GlobalVariable Property ENV_AllowPlayerSuffocation Auto Const Mandatory

Event OnTriggerEnter(ObjectReference akActionRef)
    Utility.Wait(2.0)
    Game.HideHudMenus()
    Game.SetInChargen(False, False, False)
    ENV_AllowPlayerSuffocation.SetValue(1)
    Game.FastTravel(RAS_ChooseStartCellMarkerREF01)
    FadeFromBlack.Apply()
    Utility.Wait(0.2)
    StayBlack.Remove()
    (RAS_NewGameManagerQuest as RAS_NewGameManagerQuestScript).InputLayer.Delete()
    RAS_NewGameManagerQuest.SetActive()
EndEvent