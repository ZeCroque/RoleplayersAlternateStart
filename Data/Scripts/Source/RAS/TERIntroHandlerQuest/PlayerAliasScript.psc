Scriptname RAS:TERIntroHandlerQuest:PlayerAliasScript extends ReferenceAlias

ConditionForm Property RAS_TERVanillaStartingCond Mandatory Const Auto
Keyword Property RAS_TriggerTerranArmadaEventKeyword Mandatory Const Auto

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
    If(akNewLoc)
        Quest SFTERMQIntro = Game.GetFormFromFile(0x59A0, "SFBGS050.esm") as Quest
        If(SFTERMQIntro && !SFTERMQIntro.IsRunning())
            ConditionForm AurieMQDelayConds = Game.GetFormFromFile(0x180F, "Aurie_TerranArmadaDelayedByMQ.esm") as ConditionForm
            ConditionForm AurieDelayConds = Game.GetFormFromFile(0x1807, "Aurie_TerranArmadaDelayed.esm") as ConditionForm
            If(RAS_TERVanillaStartingCond.IsTrue() && (!AurieDelayConds || AurieDelayConds.IsTrue(Game.GetPlayer())) && (!AurieMQDelayConds || AurieMQDelayConds.IsTrue(Game.GetPlayer())))
                RAS_TriggerTerranArmadaEventKeyword.SendStoryEvent()
                GetOwningQuest().Stop()
            EndIf
        EndIf
    EndIf
EndEvent