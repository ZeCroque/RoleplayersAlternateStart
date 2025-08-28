Scriptname RAS_ManageLevelActivatorScript extends ObjectReference

Message Property RAS_AddLevelMessage Mandatory Const Auto
Message Property RAS_SetLevelMessage Mandatory Const Auto

Bool NeverChangedLevel = True

Event OnLoad()
    PlayAnimation("Stage2NoTransition")
EndEvent

Event OnActivate(ObjectReference akActionRef)
    If(NeverChangedLevel)
        Int choice = RAS_SetLevelMessage.Show()
        If(choice < 5)
            If(choice == 0)
                AddLevels(4)
            ElseIf(choice == 1)
                AddLevels(9)
            ElseIf(choice == 2)
                AddLevels(24)
            ElseIf(choice == 3)
                AddLevels(49)
            Else
                ShowLevelMessage()
            EndIf
        EndIf
    Else
        ShowLevelMessage()
    EndIf
EndEvent

Function ShowLevelMessage()
    Int choice = RAS_AddLevelMessage.Show()
    If(choice < 4)
        If(choice == 0)
            AddLevels(1)
        ElseIf(choice == 1)
            AddLevels(5)
        ElseIf(choice == 2)
            AddLevels(10)
        Else
            AddLevels(50)
        EndIf
        Utility.Wait(1.5)
        ShowLevelMessage()
    EndIf
EndFunction

Function AddLevels(Int count)
    NeverChangedLevel = False
    Int PlayerLevel = Game.GetPlayerLevel()
    Game.RewardPlayerXP(Game.GetXPForLevel(PlayerLevel + count) - Game.GetXPForLevel(PlayerLevel), true)
EndFunction