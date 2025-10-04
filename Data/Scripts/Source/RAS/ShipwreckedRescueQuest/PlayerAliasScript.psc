Scriptname RAS:ShipwreckedRescueQuest:PlayerAliasScript extends ReferenceAlias

Activator Property RAS_RescueActivator Mandatory Auto Const

Event OnOutpostPlaced(ObjectReference akOutpostBeacon)
    If(GetOwningQuest().GetStageDone(5))
        GetOwningQuest().SetStage(10)
        RegisterForRemoteEvent(akOutpostBeacon, "OnWorkshopObjectPlaced")
    EndIf
EndEvent

Event ObjectReference.OnWorkshopObjectPlaced(ObjectReference akSender, ObjectReference akReference)
    If(GetOwningQuest().GetStage() < 15)
        If(akReference.GetBaseObject() == RAS_RescueActivator as Form)
            (GetOwningQuest() as RAS:ShipwreckedRescueQuest:ShipwreckedRescueQuestScript).RescueBeaconAlias.ForceRefTo(akReference)
            GetOwningQuest().SetStage(15)
            Clear()
        EndIf
    EndIf
EndEvent