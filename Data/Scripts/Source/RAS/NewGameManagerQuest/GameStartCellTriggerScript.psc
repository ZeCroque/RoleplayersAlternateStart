Scriptname RAS:NewGameManagerQuest:GameStartCellTriggerScript extends ObjectReference Const

Quest Property RAS_NewGameManagerQuest Mandatory Const Auto
ImageSpaceModifier Property StayBlack Mandatory Const Auto
Message Property RAS_ChooseStartTypeMessage Mandatory Const Auto
ActorValue Property PlayerUnityTimesEntered Mandatory Const Auto

Event OnCellLoad()        
    If(RAS_NewGameManagerQuest.GetStage() < 100)
        RAS:NewGameManagerQuest:NewGameManagerQuestScript managerQuest = RAS_NewGameManagerQuest as RAS:NewGameManagerQuest:NewGameManagerQuestScript
        managerQuest.LockPlayer()
        Game.FadeOutGame(False, True, 0.0, 0.1, False) ;finishes main menu loading

        managerQuest.StarbornStart = Game.GetPlayer().GetValue(PlayerUnityTimesEntered) > 0

        If(RAS_ChooseStartTypeMessage.Show() == 0)    
            RAS_NewGameManagerQuest.SetStage(5)
        Else
            If(!managerQuest.StarbornStart)
                managerQuest.RegisterForChargen()
                Game.PrecacheCharGen()
                Game.ShowRaceMenu(None, 0, None, None, None)
                managerQuest.InitCustomStart()
            Else
                managerQuest.InitCustomStart()
                Game.FastTravel(managerQuest.RAS_ChooseStartCellMarkerREF)
            EndIf
        EndIf
    EndIf
EndEvent