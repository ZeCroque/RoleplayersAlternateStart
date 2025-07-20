Scriptname RAS_FrontierPickUp_ChairAliasScript extends ReferenceAlias

Message Property RAS_RepairFrontierMessage Mandatory Const Auto
Message Property RAS_RepairFailedMessage Mandatory Const Auto
Message Property RAS_RepairSucceededMessage Mandatory Const Auto
Form Property ShipRepairKit Mandatory Const Auto
Form Property InorgCommonIron Mandatory Const Auto

Function RepairShip()
    GetReference().BlockActivation(False, False)
    RAS_RepairSucceededMessage.Show()
    GetOwningQuest().SetStage(20)
    Clear()
EndFunction

Event OnActivate(ObjectReference akActionRef)
    ObjectReference PlayerREF = Game.GetPlayer()
    
    Int Choice = RAS_RepairFrontierMessage.Show()
    If(Choice == 1)
        If(PlayerREF.GetComponentCount(InorgCommonIron) > 9)
            Game.GetPlayer().RemoveItemByComponent(InorgCommonIron, 10)
            RepairShip()
        Else
            RAS_RepairFailedMessage.Show()
        EndIf
    ElseIf(Choice == 2)
        If(PlayerREF.GetItemCount(ShipRepairKit) > 0)
            PlayerREF.RemoveItem(ShipRepairKit)
            RepairShip()
        Else
            RAS_RepairFailedMessage.Show()
        EndIf
    ElseIf(Choice == 3)
        RepairShip()
    Endif
EndEvent

Event OnCellLoad()
    GetOwningQuest().SetStage(10)
EndEvent