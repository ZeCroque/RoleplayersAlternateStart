Scriptname RAS_MQ101PlayerAliasScript extends ReferenceAlias

ReferenceAlias Property ShipServicesTech Mandatory Const Auto

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
    ShipServicesTech.RefillAlias()
EndEvent
