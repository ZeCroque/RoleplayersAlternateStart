Scriptname RAS_PlayerAliasScript extends ReferenceAlias

Keyword Property PCM_ArtifactCave Mandatory Const Auto
Quest Property RAS_MQReplacerQuest Mandatory Const Auto
Quest Property RAS_NewGameManagerQuest Mandatory Const Auto
Quest Property DialogueShipServices Mandatory Const Auto

Function ClearIfNoLongerNeeded()
    If((RAS_NewGameManagerQuest as RAS_NewGameManagerQuestScript).RAS_NoneShipReference == None && RAS_MQReplacerQuest.GetStage() >= 10)
        Clear()
    EndIf
EndFunction

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
    if (RAS_MQReplacerQuest.GetStage() < 10 && akNewLoc && akNewLoc.HasKeyword(PCM_ArtifactCave))
        RAS_MQReplacerQuest.Start()
        RAS_MQReplacerQuestScript MQReplacerQuestScript = RAS_MQReplacerQuest as RAS_MQReplacerQuestScript
        MQReplacerQuestScript.ArtifactLocation.ForceLocationTo(akNewLoc)
        MQReplacerQuestScript.ArtifactLocation.RefillDependentAliases()
        MQReplacerQuestScript.SetStage(10)
        ClearIfNoLongerNeeded()
    endif
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
        ClearIfNoLongerNeeded()
    EndIf
EndEvent