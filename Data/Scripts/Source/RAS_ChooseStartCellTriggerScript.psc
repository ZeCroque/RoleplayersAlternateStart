Scriptname RAS_ChooseStartCellTriggerScript extends ObjectReference Const

Quest Property RAS_NewGameManagerQuest Mandatory Const Auto
Keyword Property AnimArchetypePlayer Mandatory Const Auto
ActorValue Property Experience Mandatory Const Auto
Quest Property DialogueShipServices Mandatory Const Auto
ObjectReference Property RAS_ShipVendorMarker Mandatory Const Auto
ActorValue Property SpaceshipRegistration Mandatory Const Auto
Form Property RAS_NoneShip Mandatory Const Auto 
Armor Property Clothes_GenWare_01 Mandatory Const Auto
Message Property RAS_CustomStartTutorialMessage Mandatory Const Auto

Event OnCellLoad()
    Game.SetCharGenHUDMode(0)
    Game.SetInChargen(False, False, False)
    RAS_NewGameManagerQuest.SetActive()
    Game.GetPlayer().ChangeAnimArchetype(AnimArchetypePlayer)
    Game.GetPlayer().SetValue(Experience, 0)

    RAS_NewGameManagerQuestScript NewGameManagerQuestScript = (RAS_NewGameManagerQuest as RAS_NewGameManagerQuestScript)
    SpaceshipReference NoneShip  = RAS_ShipVendorMarker.PlaceShipAtMe(RAS_NoneShip)
    NewGameManagerQuestScript.RAS_NoneShipReference = NoneShip
    Game.AddPlayerOwnedShip(NoneShip)
    Game.TrySetPlayerHomeSpaceShip(NoneShip)
    NoneShip.SetValue(SpaceshipRegistration, 1)
    NewGameManagerQuestScript.InputLayer = InputEnableLayer.Create()
    NewGameManagerQuestScript.InputLayer.EnableFarTravel(False)
    NewGameManagerQuestScript.InputLayer.EnableGravJump(False)
    NewGameManagerQuestScript.InputLayer.EnableTakeoff(False)
    NewGameManagerQuestScript.PedestrianStart = True
    DialogueShipServices.Stop()

    Game.GetPlayer().AddItem(Clothes_GenWare_01, 1, True)
    Game.GetPlayer().EquipItem(Clothes_GenWare_01, false, true)
    
    RAS_CustomStartTutorialMessage.Show()

    Disable()
EndEvent
