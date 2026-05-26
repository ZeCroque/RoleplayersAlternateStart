Scriptname RAS:NewGameConfiguration:CustomStarbornContainer extends ObjectReference Const

ObjectReference Property StarbornContainer Mandatory Const Auto

Event OnActivate(ObjectReference akActionRef)
    StarbornContainer.OpenOneWayTransferMenu(False)
EndEvent