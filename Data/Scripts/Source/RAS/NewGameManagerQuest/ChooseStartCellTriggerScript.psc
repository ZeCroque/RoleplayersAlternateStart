Scriptname RAS:NewGameManagerQuest:ChooseStartCellTriggerScript extends ObjectReference Const

Quest Property RAS_NewGameManagerQuest Mandatory Const Auto
Keyword Property AnimArchetypePlayer Mandatory Const Auto
ActorValue Property Experience Mandatory Const Auto
Armor Property Clothes_GenWare_01 Mandatory Const Auto
Message Property RAS_CustomStartTutorialMessage Mandatory Const Auto
Armor Property Spacesuit_Constellation_01 Mandatory Const Auto
Armor Property Spacesuit_Constellation_Backpack_01 Mandatory Const Auto
Armor Property Spacesuit_Constellation_Helmet_01 Mandatory Const Auto
Armor Property Clothes_Miner_UtilitySuit Mandatory Const Auto

Event OnCellLoad()
    Game.SetCharGenHUDMode(0)
    Game.SetInChargen(False, False, False)
    RAS_NewGameManagerQuest.SetActive()
    Game.GetPlayer().ChangeAnimArchetype(AnimArchetypePlayer)
    Game.GetPlayer().SetValue(Experience, 0)

    Game.GetPlayer().RemoveItem(Spacesuit_Constellation_01, abSilent = True)
    Game.GetPlayer().RemoveItem(Spacesuit_Constellation_Backpack_01, abSilent = True)
    Game.GetPlayer().RemoveItem(Spacesuit_Constellation_Helmet_01, abSilent = True)
    Game.GetPlayer().RemoveItem(Clothes_Miner_UtilitySuit, abSilent = True)
    Game.GetPlayer().AddItem(Clothes_GenWare_01, 1, True)
    Game.GetPlayer().EquipItem(Clothes_GenWare_01, false, true)

    RAS:NewGameManagerQuest:NewGameManagerQuestScript managerQuest = RAS_NewGameManagerQuest as RAS:NewGameManagerQuest:NewGameManagerQuestScript
    managerQuest.StayBlack.Remove()
    managerQuest.InputLayer.Delete()    
    
    RAS_CustomStartTutorialMessage.Show()

    Disable()
EndEvent
