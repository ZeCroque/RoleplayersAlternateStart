Scriptname RAS_DefaultStart extends MiscObject

ObjectReference Property DynamicTerminal Mandatory Const Auto

Location Property TargetLocation  Auto
Quest Property RAS_NewGameManagerQuest Mandatory Const Auto
Message Property RAS_ImpossibleToStartMessage Mandatory Const Auto
ObjectReference Property RAS_ShipServicesActorREF Mandatory Const Auto
Keyword Property CurrentInteractionLinkedRefKeyword Mandatory Const Auto
Keyword Property LinkShipLandingMarker01 Mandatory Const Auto

Event OnInit()
    RegisterForCustomEvent(DynamicTerminal as RAS_DynamicEntriesTerminalScript, "SelectedFragmentTriggered")
EndEvent

Event RAS_DynamicEntriesTerminalScript.SelectedFragmentTriggered(RAS_DynamicEntriesTerminalScript akSender, var[] kArgs)
    If(kArgs[0] as Form == Self)
        RAS_NewGameManagerQuestScript newGameManagerQuestScript = RAS_NewGameManagerQuest as RAS_NewGameManagerQuestScript
        newGameManagerQuestScript.StartingLocationAlias.ForceLocationTo(TargetLocation)
        newGameManagerQuestScript.StartingLocationMapMarkerAlias.RefillAlias()
        newGameManagerQuestScript.StartingLocationShipMarkerAlias.RefillAlias()

        SpaceshipReference CurrentShip = (RAS_ShipServicesActorREF as RAS_ShipVendorScript).currentShip
Debug.Trace("mappmarker" + newGameManagerQuestScript.StartingLocationMapMarkerAlias.GetReference())
        ObjectReference startMarker = newGameManagerQuestScript.StartingLocationMapMarkerAlias.GetReference()
        If(startMarker)
            Game.GetPlayer().MoveTo(startMarker)
            newGameManagerQuestScript.StartingLocationShipTechAlias.RefillAlias()
            ObjectReference shipTech = newGameManagerQuestScript.StartingLocationShipTechAlias.GetReference()
            Debug.Trace("tecch" + shipTech)
            If(shipTech)
                ObjectReference shipMarker = shipTech.GetLinkedRef(LinkShipLandingMarker01)
                Debug.Trace("marker" + shipMarker)
                CurrentShip.MoveTo(shipMarker)
                CurrentShip.SetLinkedRef(shipMarker, CurrentInteractionLinkedRefKeyword)
                CurrentShip.Enable()
                Game.GetPlayer().MoveTo(shipMarker)
            Else
                ObjectReference shipMarker = newGameManagerQuestScript.StartingLocationShipMarkerAlias.GetReference()
                If(shipMarker)
                    Debug.Trace("marker" + shipMarker)
                    CurrentShip.MoveTo(shipMarker)
                    CurrentShip.SetLinkedRef(shipMarker, CurrentInteractionLinkedRefKeyword)
                    CurrentShip.Enable()
                EndIf
            EndIf
        Else
            RAS_ImpossibleToStartMessage.Show()
        EndIf
    Endif
EndEvent
