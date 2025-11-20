Scriptname RAS:NewGameManagerQuest:GameStartCellTriggerScript extends ObjectReference Const

Quest Property RAS_NewGameManagerQuest Mandatory Const Auto
ImageSpaceModifier Property StayBlack Mandatory Const Auto
Message Property RAS_ChooseStartTypeMessage Mandatory Const Auto

Event OnCellLoad()        
    Game.HideHudMenus()
    ;Game.SetCharGenHUDMode(1)
    StayBlack.Apply() 
    Game.FadeOutGame(False, True, 0.0, 0.1, False) ;finishes main menu loading

    Game.SetInChargen(True, True, False)
    (RAS_NewGameManagerQuest as RAS:NewGameManagerQuest:NewGameManagerQuestScript).InputLayer = InputEnableLayer.Create()
    (RAS_NewGameManagerQuest as RAS:NewGameManagerQuest:NewGameManagerQuestScript).InputLayer.DisablePlayerControls()

    If(RAS_ChooseStartTypeMessage.Show() == 0)    
        RAS_NewGameManagerQuest.SetStage(5)
    Else
        (RAS_NewGameManagerQuest as RAS:NewGameManagerQuest:NewGameManagerQuestScript).InitCustomStart()
        Game.PrecacheCharGen()
        Game.ShowRaceMenu(None, 0, None, None, None) 
    EndIf
EndEvent