Scriptname RAS:NewGameManagerQuest:ChooseStartCellTriggerScript extends ObjectReference Const

Quest Property RAS_NewGameManagerQuest Mandatory Const Auto
Keyword Property AnimArchetypePlayer Mandatory Const Auto
ActorValue Property Experience Mandatory Const Auto
Armor Property Clothes_GenWare_01 Mandatory Const Auto
Message Property RAS_CustomStartTutorialMessage Mandatory Const Auto
Quest Property RAS_ShipManagerQuest Mandatory Const Auto

Event OnCellLoad()
    Game.SetCharGenHUDMode(0)
    Game.SetInChargen(False, False, False)
    RAS_NewGameManagerQuest.SetActive()
    Game.GetPlayer().ChangeAnimArchetype(AnimArchetypePlayer)
    Game.GetPlayer().SetValue(Experience, 0)

    (RAS_ShipManagerQuest as RAS:ShipManagerQuest:ShipManagerQuestScript).InitNoneShip()

    Game.GetPlayer().AddItem(Clothes_GenWare_01, 1, True)
    Game.GetPlayer().EquipItem(Clothes_GenWare_01, false, true)
    
    RAS_CustomStartTutorialMessage.Show()

    Disable()
EndEvent
