Scriptname RAS:NewGameManagerQuest:GameStartCellTriggerScript extends ObjectReference Const

Quest Property RAS_NewGameManagerQuest Mandatory Const Auto
ImageSpaceModifier Property StayBlack Mandatory Const Auto
Message Property RAS_ChooseStartTypeMessage Mandatory Const Auto
ObjectReference Property RAS_ChooseStartCellMarkerREF Mandatory Const Auto

Event OnCellLoad()    

    StayBlack.Apply() 
    Game.FadeOutGame(False, True, 0.0, 3.0, False)
    ; While !Game.GetPlayer().Is3DLoaded()
    ;     Utility.Wait(1.0)
    ; EndWhile


    ;Game.HideHudMenus()
    Game.SetInChargen(True, True, False)

    (RAS_NewGameManagerQuest as RAS:NewGameManagerQuest:NewGameManagerQuestScript).InputLayer = InputEnableLayer.Create()
    (RAS_NewGameManagerQuest as RAS:NewGameManagerQuest:NewGameManagerQuestScript).InputLayer.DisablePlayerControls()

    Debug.Trace("oigrirgrioj")
    RAS_NewGameManagerQuest.Start()
    If(RAS_ChooseStartTypeMessage.Show() == 0)
        RAS_NewGameManagerQuest.SetStage(5)
    Else
        (RAS_NewGameManagerQuest as RAS:NewGameManagerQuest:NewGameManagerQuestScript).FastTravelTarget = RAS_ChooseStartCellMarkerREF
        RAS_NewGameManagerQuest.SetStage(10)
    EndIf
EndEvent