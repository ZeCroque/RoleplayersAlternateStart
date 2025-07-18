Scriptname RAS_MQ101PlayerAliasScript extends ReferenceAlias

ReferenceAlias Property ShipServicesTech Mandatory Const Auto

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
    If(GetOwningQuest().GetStage() == 0)
        ShipServicesTech.RefillAlias()
    Else
        Clear()
    EndIf
EndEvent
