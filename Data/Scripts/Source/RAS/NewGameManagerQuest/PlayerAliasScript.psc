Scriptname RAS:NewGameManagerQuest:PlayerAliasScript extends ReferenceAlias

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
Message Property RAS_ChooseStartTypeMessage Mandatory Const Auto
Actor Property RAS_ShipServicesActorREF Mandatory Const Auto
ObjectReference Property RAS_HomeChoosingTerminalREF Mandatory Const Auto
ObjectReference Property RAS_NarrativeAdjustmentsActivatorREF Mandatory Const Auto

Function ClearIfNoLongerNeeded()
    If((RAS_NewGameManagerQuest as RAS:NewGameManagerQuest:NewGameManagerQuestScript).RAS_NoneShipReference == None && RAS_MQ101.GetStage() == 1810)
        Clear()
    EndIf
EndFunction

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
    If(akNewLoc)
        If(RAS_NewGameManagerQuest.GetStage() == 11)
            RAS_NewGameManagerQuest.SetStage(100)

            ;If player has picked a ship, deletes the none ship (will prevent player alias events from firing)
            SpaceshipReference currentShip = (RAS_ShipServicesActorREF as RAS:NewGameConfiguration:ShipVendorScript).currentShip
            If(currentShip != (RAS_NewGameManagerQuest as RAS:NewGameManagerQuest:NewGameManagerQuestScript).RAS_NoneShipReference) 
                (RAS_NewGameManagerQuest as RAS:NewGameManagerQuest:NewGameManagerQuestScript).SetupPlayerShip(currentShip)
            EndIf

            ;If player picked a home, give it to them
            (RAS_HomeChoosingTerminalREF as RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript).CallSelectedFragment()

            ;Triggers narrative adjustments
            (RAS_NarrativeAdjustmentsActivatorREF as RAS:NewGameConfiguration:DynamicTerminals:NarrativeAdjustments:NarrativeAdjustmentsActivatorScript).TriggerAllValidFragment()
        ElseIf(RAS_MQReplacerQuest.GetStage() < 10 && akNewLoc && akNewLoc.HasKeyword(PCM_ArtifactCave))
            RAS_MQReplacerQuest.Start()
            RAS:MQReplacer:MQReplacerScript MQReplacerQuestScript = RAS_MQReplacerQuest as RAS:MQReplacer:MQReplacerScript
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
        SpaceshipReference NoneShip = (RAS_NewGameManagerQuest as RAS:NewGameManagerQuest:NewGameManagerQuestScript).RAS_NoneShipReference
        If(NoneShip)
            Game.RemovePlayerOwnedShip(NoneShip)
            (RAS_NewGameManagerQuest as RAS:NewGameManagerQuest:NewGameManagerQuestScript).SetupPlayerShip(akShip)
            ClearIfNoLongerNeeded()
        EndIf
    EndIf
EndEvent

Event OnItemUnequipped(Form akBaseObject, ObjectReference akReference)
    If((RAS_NewGameManagerQuest as RAS:NewGameManagerQuest:NewGameManagerQuestScript).StarbornVanillaStart && RAS_MQ101.GetStageDone(25) == False)
        RAS_TmpItemsToEquipBack.AddForm(akBaseObject)
    EndIf
EndEvent