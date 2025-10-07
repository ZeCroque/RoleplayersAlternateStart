Scriptname RAS:ShipwreckedRescueQuest:PlayerAliasScript extends ReferenceAlias

Activator Property RAS_RescueActivator Mandatory Auto Const
MiscObject Property Mfg_Tier01_CommRelay Mandatory Const Auto
MiscObject Property InorgCommonCopper Mandatory Const Auto
MiscObject Property InorgCommonAluminum Mandatory Const Auto
GlobalVariable Property RAS_ShipwreckedRescueQuest_AluminumCount Mandatory Const Auto
GlobalVariable Property RAS_ShipwreckedRescueQuest_CopperCount Mandatory Const Auto

Event OnInit()
    AddInventoryEventFilter(Mfg_Tier01_CommRelay)
    AddInventoryEventFilter(InorgCommonCopper)
    AddInventoryEventFilter(InorgCommonAluminum)
EndEvent

Function UpdateQuestIfApplicable()
    If(GetOwningQuest().IsObjectiveCompleted(0) && GetOwningQuest().IsObjectiveCompleted(1) && GetOwningQuest().IsObjectiveCompleted(2))
        GetOwningQuest().SetStage(5)
    EndIf
EndFunction

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer, int aiTransferReason)
    If(akBaseItem == Mfg_Tier01_CommRelay)
        GetOwningQuest().SetObjectiveCompleted(2)
        RemoveInventoryEventFilter(Mfg_Tier01_CommRelay)
        UpdateQuestIfApplicable()
    ElseIf(akBaseItem == InorgCommonCopper)
        Int newValue = RAS_ShipwreckedRescueQuest_CopperCount.GetValueInt() + aiItemCount
        If(newValue < 5)
            RAS_ShipwreckedRescueQuest_CopperCount.SetValue(newValue)
        Else
            RAS_ShipwreckedRescueQuest_CopperCount.SetValue(5)
            RemoveInventoryEventFilter(InorgCommonCopper)
            GetOwningQuest().SetObjectiveCompleted(1)
            UpdateQuestIfApplicable()
        EndIf
        GetOwningQuest().UpdateCurrentInstanceGlobal(RAS_ShipwreckedRescueQuest_CopperCount)
    Else
        Int newValue = RAS_ShipwreckedRescueQuest_AluminumCount.GetValueInt() + aiItemCount
        If(newValue < 5)
            RAS_ShipwreckedRescueQuest_AluminumCount.SetValue(newValue)
        Else
            RAS_ShipwreckedRescueQuest_AluminumCount.SetValue(5)
            RemoveInventoryEventFilter(InorgCommonAluminum)
            GetOwningQuest().SetObjectiveCompleted(0)
            UpdateQuestIfApplicable()
        EndIf
        GetOwningQuest().UpdateCurrentInstanceGlobal(RAS_ShipwreckedRescueQuest_AluminumCount)
    EndIf
EndEvent

Event OnOutpostPlaced(ObjectReference akOutpostBeacon)
    If(GetOwningQuest().GetStage() < 10)
        GetOwningQuest().SetStage(10)
        RegisterForRemoteEvent(akOutpostBeacon, "OnWorkshopObjectPlaced")
    EndIf
EndEvent

Event ObjectReference.OnWorkshopObjectPlaced(ObjectReference akSender, ObjectReference akReference)
    If(GetOwningQuest().GetStage() < 15)
        If(akReference.GetBaseObject() == RAS_RescueActivator as Form)
            (GetOwningQuest() as RAS:ShipwreckedRescueQuest:ShipwreckedRescueQuestScript).RescueBeaconAlias.ForceRefTo(akReference)
            GetOwningQuest().SetStage(15)
        EndIf
    EndIf
EndEvent

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
    If(GetOwningQuest().GetStage() < 30)
        RAS:ShipwreckedRescueQuest:ShipwreckedRescueQuestScript shipwreckedRescueQuestScript = (GetOwningQuest() as RAS:ShipwreckedRescueQuest:ShipwreckedRescueQuestScript)
        If(akNewLoc.GetCurrentPlanet() != shipwreckedRescueQuestScript.PlanetAlias.GetLocation().GetCurrentPlanet())
            GetOwningQuest().FailAllObjectives()
            GetOwningQuest().SetStage(40)
            shipwreckedRescueQuestScript.ClearPlanetaryHabSkillChanges()
        EndIf
    Else
        RAS:ShipwreckedRescueQuest:ShipwreckedRescueQuestScript shipwreckedRescueQuestScript = (GetOwningQuest() as RAS:ShipwreckedRescueQuest:ShipwreckedRescueQuestScript)
        Game.GetPlayer().MoveTo(shipwreckedRescueQuestScript.ShipMapMarkerAlias.GetReference())
        shipwreckedRescueQuestScript.ClearPlanetaryHabSkillChanges()
        Utility.Wait(2)
        Self.RegisterForDistanceGreaterThanEvent(Game.GetPlayer(), shipwreckedRescueQuestScript.ShipAlias.GetReference(), 20)
    EndIf
EndEvent

Event OnDistanceGreaterThan(ObjectReference akObj1, ObjectReference akObj2, float afDistance, int aiEventID)
    SpaceshipReference ship = (GetOwningQuest() as RAS:ShipwreckedRescueQuest:ShipwreckedRescueQuestScript).ShipAlias.GetShipReference()
    Self.UnregisterForDistanceEvents(Game.GetPlayer(), ship)
    ship.DisableWithTakeOffOrLanding()
    GetOwningQuest().SetStage(50)
EndEvent