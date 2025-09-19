Scriptname RAS:MQ101:PlayerAliasScript extends ReferenceAlias

ReferenceAlias Property ShipServicesTech Mandatory Const Auto
Perk Property Trait_KidStuff Mandatory Const Auto
Quest Property TraitKidStuff Mandatory Const Auto

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
    If(GetOwningQuest().GetStage() == 0)
        ShipServicesTech.RefillAlias()
    ElseIf(GetOwningQuest().GetStage() == 1800 || GetOwningQuest().GetStage() == 2100)
        ;Stopping stage to reset lodge packages and so on
        GetOwningQuest().SetStage(1810)
        If Game.GetPlayer().HasPerk(Trait_KidStuff)
            TraitKidStuff.SetStage(50)
        EndIf
        Clear()
    EndIf
EndEvent
