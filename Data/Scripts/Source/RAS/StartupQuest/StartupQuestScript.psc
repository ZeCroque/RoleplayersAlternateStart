Scriptname RAS:StartupQuest:StartupQuestScript extends Quest

ObjectReference Property RAS_GameStartCellMarkerREF Mandatory Const Auto

Event OnQuestStarted()
    Game.FastTravel(RAS_GameStartCellMarkerREF)  
EndEvent