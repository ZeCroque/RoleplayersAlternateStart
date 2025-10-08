Scriptname RAS:BrokenShipQuest:PlayerAliasScript extends ReferenceAlias

Potion Property ShipRepairKit Mandatory Const Auto
MiscObject Property InorgCommonIron Mandatory Const Auto
GlobalVariable Property RAS_BrokenShipQuest_IronCount Mandatory Const Auto

Event OnInit()
    AddInventoryEventFilter(ShipRepairKit)
    AddInventoryEventFilter(InorgCommonIron)
EndEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer, int aiTransferReason)
    If(akBaseItem == ShipRepairKit)
        GetOwningQuest().SetObjectiveCompleted(0)
        GetOwningQuest().SetObjectiveCompleted(1)
        RemoveInventoryEventFilter(InorgCommonIron)
        RemoveInventoryEventFilter(ShipRepairKit)
        GetOwningQuest().SetStage(5)
    Else
        Int newValue = RAS_BrokenShipQuest_IronCount.GetValueInt() + aiItemCount
        If(newValue < 10)
            RAS_BrokenShipQuest_IronCount.SetValue(newValue)
        Else
            RAS_BrokenShipQuest_IronCount.SetValue(10)
            GetOwningQuest().SetObjectiveCompleted(0)
            GetOwningQuest().SetObjectiveCompleted(1)
            RemoveInventoryEventFilter(InorgCommonIron)
            RemoveInventoryEventFilter(ShipRepairKit)
            GetOwningQuest().SetStage(5)
        EndIf
        GetOwningQuest().UpdateCurrentInstanceGlobal(RAS_BrokenShipQuest_IronCount)
    EndIf
EndEvent