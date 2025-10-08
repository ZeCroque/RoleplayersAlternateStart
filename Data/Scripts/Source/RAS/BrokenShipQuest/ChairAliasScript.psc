Scriptname RAS:BrokenShipQuest:ChairAliasScript extends ReferenceAlias

Message Property RAS_RepairShipMessage Mandatory Const Auto
Message Property RAS_RepairFailedMessage Mandatory Const Auto
Message Property RAS_RepairSucceededMessage Mandatory Const Auto
Potion Property ShipRepairKit Mandatory Const Auto
MiscObject Property InorgCommonIron Mandatory Const Auto

Function RepairShip()
    GetReference().BlockActivation(False, False)
    RAS_RepairSucceededMessage.Show()
    GetOwningQuest().SetStage(10)
EndFunction

Event OnActivate(ObjectReference akActionRef)
    ObjectReference PlayerREF = Game.GetPlayer()
    
    Int Choice = RAS_RepairShipMessage.Show()
    If(Choice == 1)
        If(PlayerREF.GetItemCount(ShipRepairKit) > 0)
            PlayerREF.RemoveItem(ShipRepairKit)
            RepairShip()
        Else
            RAS_RepairFailedMessage.Show()
        EndIf
    ElseIf(Choice == 2)
        If(PlayerREF.GetComponentCount(InorgCommonIron) > 9)
            Game.GetPlayer().RemoveItemByComponent(InorgCommonIron, 10)
            RepairShip()
        Else
            RAS_RepairFailedMessage.Show()
        EndIf
    ElseIf(Choice == 3)
        RepairShip()
    Endif
EndEvent