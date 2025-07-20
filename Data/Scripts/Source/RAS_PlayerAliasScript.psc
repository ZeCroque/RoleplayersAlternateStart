Scriptname RAS_PlayerAliasScript extends ReferenceAlias

Keyword Property PCM_ArtifactCave Mandatory Const Auto
Quest Property RAS_MQReplacerQuest Mandatory Const Auto
Quest Property RAS_NewGameManagerQuest Mandatory Const Auto
Quest Property DialogueShipServices Mandatory Const Auto
Quest Property MQ101 Mandatory Const Auto
Quest Property RAS_MQ101 Mandatory Const Auto
Location Property VecteraMineLocation Mandatory Const Auto
ReferenceAlias Property Heller Mandatory Const Auto
Keyword Property AnimFlavorTechReader Mandatory Const Auto

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
        ElseIf(RAS_MQ101.GetStage() == 1800)
            ;Stopping MQ101 to reset lodge packages and so on
            RAS_MQ101.SetStage(1810)
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
    SpaceshipReference NoneShip = (RAS_NewGameManagerQuest as RAS_NewGameManagerQuestScript).RAS_NoneShipReference
    If(NoneShip && akShip != NoneShip)
        Game.RemovePlayerOwnedShip(NoneShip)
        NoneShip.Disable()
        RAS_NewGameManagerQuestScript NewGameManagerQuestScript = (RAS_NewGameManagerQuest as RAS_NewGameManagerQuestScript)
        NewGameManagerQuestScript.RAS_NoneShipReference = None
        NewGameManagerQuestScript.PlayerShipless = False
        NewGameManagerQuestScript.InputLayer.Delete()
        DialogueShipServices.Reset()
        DialogueShipServices.Start()
        akShip.SetExteriorLoadDoorInaccessible(False)
        ClearIfNoLongerNeeded()
    EndIf
EndEvent