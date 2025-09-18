Scriptname RAS:NewGameManagerQuest:TmpCellTriggerScript extends ObjectReference Const

Quest Property RAS_NewGameManagerQuest Mandatory Const Auto
ImageSpaceModifier Property StayBlack Mandatory Const Auto
ImageSpaceModifier Property FadeFromBlack Mandatory Const Auto

Event OnCellLoad()
    Message.ClearHelpMessages()
    Utility.Wait(2.0)
    Game.HideHudMenus() 
    Game.FastTravel((RAS_NewGameManagerQuest as RAS:NewGameManagerQuest:NewGameManagerQuestScript).FastTravelTarget)

    If((RAS_NewGameManagerQuest as RAS:NewGameManagerQuest:NewGameManagerQuestScript).StarbornStart == False)   
        FadeFromBlack.Apply()
        Utility.Wait(0.2)
        StayBlack.Remove()
        (RAS_NewGameManagerQuest as RAS:NewGameManagerQuest:NewGameManagerQuestScript).InputLayer.Delete()
    EndIf
EndEvent