Scriptname RAS_PlayerAliasScript extends ReferenceAlias

Keyword Property PCM_ArtifactCave Mandatory Const Auto
Quest Property RAS_MQReplacerQuest Mandatory Const Auto

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
    if akNewLoc && akNewLoc.HasKeyword(PCM_ArtifactCave)
        RAS_MQReplacerQuest.Start()
        RAS_MQReplacerQuestScript MQReplacerQuestScript = RAS_MQReplacerQuest as RAS_MQReplacerQuestScript
        MQReplacerQuestScript.ArtifactLocation.ForceLocationTo(akNewLoc)
        MQReplacerQuestScript.ArtifactLocation.RefillDependentAliases()
        MQReplacerQuestScript.SetStage(10)
        Clear()
    endif
EndEvent