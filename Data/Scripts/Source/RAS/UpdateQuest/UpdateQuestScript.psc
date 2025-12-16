Scriptname RAS:UpdateQuest:UpdateQuestScript extends Quest

GlobalVariable Property RAS_ModVersion Mandatory Const Auto
GlobalVariable Property MQ204_TurnOffCF01Arrest Mandatory Const Auto
ActorValue Property RAS_AlternateStart Mandatory Const Auto
Quest Property RAS_ShipManagerQuest Mandatory Const Auto
Quest Property MQ103 Mandatory Const Auto
Quest Property MQ104A Mandatory Const Auto
Quest Property RAS_MQ104B Mandatory Const Auto
Quest Property MQ105 Mandatory Const Auto
Quest Property TraitQuest Mandatory Const Auto
Quest Property TraitUnwantedHero Mandatory Const Auto
Perk Property TRAIT_UnwantedHero Mandatory Const Auto
ActorValue Property RAS_MinerStart Mandatory Const Auto

Float LastVersion = 1.10

Event OnQuestInit()
    Update()
EndEvent

Function Update()
    If(Game.GetPlayer().GetValueInt(RAS_AlternateStart))
        If(RAS_ModVersion.GetValue() < 1.03)
            If((RAS_ShipManagerQuest as RAS:ShipManagerQuest:ShipManagerQuestScript).PedestrianStart)
                MQ204_TurnOffCF01Arrest.SetValueInt(1)
            EndIf
        EndIf
        If(RAS_ModVersion.GetValue() < 1.04)
            If MQ103.IsCompleted() && MQ104A.IsCompleted() && RAS_MQ104B.IsCompleted()
                If (MQ105.IsCompleted() == False) && (MQ105.IsRunning() == False)
                    MQ105.SetStage(10)
                EndIf
            Else
                (RAS_MQ104B as RAS:MQ104B:MQ104BScript).HookMQ()
            EndIf

            TraitQuest.Start()
            If(Game.GetPlayer().HasPerk(TRAIT_UnwantedHero))
                If(RAS_MQ104B.IsCompleted())
                    TraitUnwantedHero.SetStage(80)
                Else
                    TraitUnwantedHero.Stop()
                EndIf
            EndIf
        EndIf
        If(RAS_ModVersion.GetValue() < 1.10)
            Game.GetPlayer().SetValue(RAS_MinerStart, 1.0)
        EndIf
    EndIf        
    RAS_ModVersion.SetValue(LastVersion)
EndFunction

