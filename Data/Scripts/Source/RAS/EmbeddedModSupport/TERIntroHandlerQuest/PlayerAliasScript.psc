Scriptname RAS:EmbeddedModSupport:TERIntroHandlerQuest:PlayerAliasScript extends ReferenceAlias

ConditionForm Property RAS_IsStartupEnded Mandatory Const Auto

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
    If(akNewLoc)
        Quest SFTERMQIntro = Game.GetFormFromFile(0x59A0, "SFBGS050.esm") as Quest
        If(SFTERMQIntro && !SFTERMQIntro.IsRunning())
            ConditionForm AurieMQDelayConds = Game.GetFormFromFile(0x180F, "Aurie_TerranArmadaDelayedByMQ.esm") as ConditionForm
            ConditionForm AurieDelayConds = Game.GetFormFromFile(0x1807, "Aurie_TerranArmadaDelayed.esm") as ConditionForm
            Form AurieNoAutoStartQuest = Game.GetFormFromFile(0x81D, "Aurie_TerranArmadaNoAutoStart.esm")
            If(RAS_IsStartupEnded.IsTrue())
                If(!AurieNoAutoStartQuest && (!AurieDelayConds || AurieDelayConds.IsTrue(Game.GetPlayer())) && (!AurieMQDelayConds || AurieMQDelayConds.IsTrue(Game.GetPlayer())))
                    SFTERMQIntro.Start()
                EndIf
            EndIf
        EndIf
    EndIf
EndEvent