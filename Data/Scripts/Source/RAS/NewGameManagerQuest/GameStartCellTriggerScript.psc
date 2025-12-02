Scriptname RAS:NewGameManagerQuest:GameStartCellTriggerScript extends ObjectReference Const

Quest Property RAS_NewGameManagerQuest Mandatory Const Auto
ImageSpaceModifier Property StayBlack Mandatory Const Auto
Message Property RAS_ChooseStartTypeMessage Mandatory Const Auto
ActorValue Property PlayerUnityTimesEntered Mandatory Const Auto

Event OnCellLoad()        
    RAS:NewGameManagerQuest:NewGameManagerQuestScript managerQuest = RAS_NewGameManagerQuest as RAS:NewGameManagerQuest:NewGameManagerQuestScript
    managerQuest.LockPlayer()
    Game.FadeOutGame(False, True, 0.0, 0.1, False) ;finishes main menu loading

    Bool isStarbornStart = Game.GetPlayer().GetValue(PlayerUnityTimesEntered) > 0
    managerQuest.StarbornStart = isStarbornStart

    If(RAS_ChooseStartTypeMessage.Show() == 0)    
        RAS_NewGameManagerQuest.SetStage(5)
    Else
        (RAS_NewGameManagerQuest as RAS:NewGameManagerQuest:NewGameManagerQuestScript).InitCustomStart()
        Game.PrecacheCharGen()
        Game.ShowRaceMenu(None, isStarbornStart as Int, None, None, None)
    EndIf
EndEvent