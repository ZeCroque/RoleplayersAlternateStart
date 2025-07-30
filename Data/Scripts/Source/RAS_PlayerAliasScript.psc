Scriptname RAS_PlayerAliasScript extends ReferenceAlias

Keyword Property PCM_ArtifactCave Mandatory Const Auto
Quest Property RAS_MQReplacerQuest Mandatory Const Auto
Quest Property RAS_NewGameManagerQuest Mandatory Const Auto
Quest Property MQ101 Mandatory Const Auto
Quest Property RAS_MQ101 Mandatory Const Auto
Quest Property TraitKidStuff Mandatory Const Auto
Location Property VecteraMineLocation Mandatory Const Auto
ReferenceAlias Property Heller Mandatory Const Auto
Keyword Property AnimFlavorTechReader Mandatory Const Auto
Perk Property Trait_KidStuff Mandatory Const Auto
FormList Property RAS_TmpItemsToEquipBack Mandatory Const Auto 

Function ClearIfNoLongerNeeded()
    If((RAS_NewGameManagerQuest as RAS_NewGameManagerQuestScript).RAS_NoneShipReference == None && RAS_MQ101.GetStage() == 1810)
        Clear()
    EndIf
EndFunction

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
    If(akNewLoc)
        If(RAS_MQReplacerQuest.GetStage() < 10 && akNewLoc && akNewLoc.HasKeyword(PCM_ArtifactCave))
            RAS_MQReplacerQuest.Start()
            RAS_MQReplacerQuestScript MQReplacerQuestScript = RAS_MQReplacerQuest as RAS_MQReplacerQuestScript
            MQReplacerQuestScript.ArtifactLocation.ForceLocationTo(akNewLoc)
            MQReplacerQuestScript.ArtifactLocation.RefillDependentAliases()
            MQReplacerQuestScript.SetStage(10)
        ElseIf(RAS_MQ101.GetStage() == 1800 || RAS_MQ101.GetStage() == 2100)
            ;Stopping MQ101 to reset lodge packages and so on
            RAS_MQ101.SetStage(1810)
            If Game.GetPlayer().HasPerk(Trait_KidStuff)
                TraitKidStuff.SetStage(50)
            EndIf
            ClearIfNoLongerNeeded()
        ElseIf(akNewLoc == VecteraMineLocation && RAS_NewGameManagerQuest.GetStage() == 5)
            ;Vanilla start
            RAS_NewGameManagerQuest.Stop()
            MQ101.SetObjectiveDisplayed(5, True, True)
            Heller.GetReference().RemoveKeyword(AnimFlavorTechReader)
            Heller.GetReference().Reset(Game.GetPlayer())
            Clear()
        Endif
    EndIf
EndEvent

Event OnHomeShipSet(SpaceshipReference akShip, SpaceshipReference akPrevious)
    If(RAS_NewGameManagerQuest.GetStageDone(100))
        SpaceshipReference NoneShip = (RAS_NewGameManagerQuest as RAS_NewGameManagerQuestScript).RAS_NoneShipReference
        If(NoneShip)
            Game.RemovePlayerOwnedShip(NoneShip)
            (RAS_NewGameManagerQuest as RAS_NewGameManagerQuestScript).SetupPlayerShip(akShip)
            ClearIfNoLongerNeeded()
        EndIf
    EndIf
EndEvent

Event OnItemUnequipped(Form akBaseObject, ObjectReference akReference)
    If((RAS_NewGameManagerQuest as RAS_NewGameManagerQuestScript).StarbornVanillaStart && RAS_MQ101.GetStageDone(25) == False)
        RAS_TmpItemsToEquipBack.AddForm(akBaseObject)
    EndIf
EndEvent