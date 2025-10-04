Scriptname RAS:ShipwreckedRescueQuest:RescueActivatorScript extends ObjectReference

Furniture Property ShipLandingMarker_60m_Medium Mandatory Const Auto
Static Property XMarker Mandatory Const Auto
Message Property RAS_UnableToPlaceRescueShipMessage Mandatory Const Auto
Keyword Property CurrentInteractionLinkedRefKeyword Mandatory Const Auto
LeveledSpaceshipBase Property LShip_Vendor_Generic_A_Responder Mandatory Const Auto
Message Property RAS_RescueShipYetCalledMessage Mandatory Const Auto
Quest Property RAS_ShipwreckedRescueQuest Mandatory Const Auto

bool Function CheckLandingSpace(ObjectReference markerRef)
	Int i = -30
	Int j = -30
	While i < 30
		While j < 30
			Float[] offsets = new Float[6]
			offsets[0] = i
			offsets[1] = j
			offsets[2] = 0.0
			offsets[3] = 0.0
			offsets[4] = 0.0
			offsets[5] = 0.0
			ObjectReference test1 = markerRef.PlaceAtMe(XMarker, 1, False, False, True, offsets, None, False)
			ObjectReference test2 = markerRef.PlaceAtMe(XMarker, 1, False, False, True, offsets, None, True)
			Float distance = test1.GetDistance(test2)
			test1.Delete()
			test2.Delete()
			If distance > 2
				Return False
			EndIf
			j += 1
		EndWhile
		i += 1
	EndWhile
	Return True
EndFunction

Function MakeAvailable()
    GotoState("Available")
EndFunction

Auto State Available
    Event OnActivate(ObjectReference akActionRef)
        GotoState("AwaitingPlayerBoarding")

        Float[] offsets = new Float[6]
        offsets[5] = 180.0 ;Make it spawn with door in front of player
        
        ObjectReference landingMarker
        Bool landingZoneAvailable = False
        Int triesCount = 0
        While(!landingZoneAvailable && triesCount < 10)
            offsets[0] = Utility.RandomInt()
            offsets[1] = Utility.RandomInt()
            landingMarker = Game.GetPlayer().PlaceAtMe(ShipLandingMarker_60m_Medium, 1, False, False, True, offsets, None, True)
            landingZoneAvailable = CheckLandingSpace(landingMarker)
        EndWhile
        
        If(landingZoneAvailable)
            If(RAS_ShipwreckedRescueQuest.GetStage() == 30)
                RAS_ShipwreckedRescueQuest.Reset()
            EndIf
            RAS_ShipwreckedRescueQuest.SetStage(20)

            SpaceshipReference ship = landingMarker.PlaceShipAtMe(LShip_Vendor_Generic_A_Responder, aiLevelMod = 2, abInitiallyDisabled = true)
            ship.SetLinkedRef(landingMarker, CurrentInteractionLinkedRefKeyword, True)
            ship.EnableWithLanding()
            (RAS_ShipwreckedRescueQuest as RAS:ShipwreckedRescueQuest:ShipwreckedRescueQuestScript).SetRescueShip(ship)
        Else
            RAS_UnableToPlaceRescueShipMessage.Show()
        EndIf
    EndEvent
EndState

State AwaitingPlayerBoarding
    Event OnActivate(ObjectReference akActionRef)
        RAS_RescueShipYetCalledMessage.Show()
    EndEvent
EndState