Scriptname RAS:NewGameManagerQuest:PlayerStuffActivatorScript extends ObjectReference Const

Quest Property RAS_NewGameManagerQuest Mandatory Const Auto
Message Property RAS_PlayerStuffPickedUp Mandatory Const Auto
Quest Property RAS_PlayerStuffPickupQuest Mandatory Const Auto

Event OnActivate(ObjectReference akActionRef)
    (RAS_NewGameManagerQuest as RAS:NewGameManagerQuest:NewGameManagerQuestScript).RestoreItems()
    RAS_PlayerStuffPickedUp.Show()
    RAS_PlayerStuffPickupQuest.SetStage(10)
    Disable()
EndEvent