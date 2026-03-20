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
Quest Property RAS_NewGameManagerQuest Mandatory Const Auto
ActorValue Property Experience Mandatory Const Auto
ObjectReference Property NewAtlantisToLodgeDoorREF Mandatory Const Auto
Quest Property MQ101 Mandatory Const Auto
Quest Property RAS_MQ101 Mandatory Const Auto
GlobalVariable Property MissionBoardAccessAllowed_Constellation Mandatory Const Auto
Quest Property SQ_PlayerShip Mandatory Const Auto
GlobalVariable Property MQ101Debug Mandatory Const Auto
Quest Property Trait_RaisedUniversalBoxEnabler Mandatory Const Auto
Quest Property Trait_RaisedEnlightenedBoxEnabler Mandatory Const Auto
GlobalVariable Property RAS_DisableStarborn Mandatory Const Auto
Perk Property StarbornSkillCheck Auto Const Mandatory

Float LastVersion = 1.12

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

            If MQ103.IsCompleted() && MQ104A.IsCompleted() && RAS_MQ104B.IsCompleted()
                If (MQ105.IsCompleted() == False) && (MQ105.IsRunning() == False)
                    MQ105.SetStage(10)
                EndIf
            Else
                (RAS_NewGameManagerQuest as RAS:NewGameManagerQuest:NewGameManagerQuestScript).RegisterMQ105Triggers()
            EndIf
        EndIf
        If(RAS_ModVersion.GetValue() < 1.11)
            Float XP = Game.GetPlayer().GetValue(Experience)
            Float ExpectedXP = Game.GetXPForLevel(Game.GetPlayerLevel())
            If(XP < ExpectedXP)
                Game.GetPlayer().SetValue(Experience, ExpectedXP)
            EndIf

            If(MQ101.GetStageDone(1810))
                NewAtlantisToLodgeDoorREF.BlockActivation(false)
            EndIf    

            If(RAS_MQ101.GetStageDone(1800))
                MissionBoardAccessAllowed_Constellation.SetValueInt(1)
            EndIf    

            RAS:ShipManagerQuest:ShipManagerQuestScript shipManagerScript = (RAS_ShipManagerQuest as RAS:ShipManagerQuest:ShipManagerQuestScript)
            If(shipManagerScript.PedestrianStart)
                (SQ_PlayerShip as SQ_PlayerShipScript).PlayerShip.ForceRefTo(shipManagerScript.CurrentShip)
            EndIf
        EndIf
        If(RAS_ModVersion.GetValue() < 1.12)
            MQ101Debug.SetValueInt(11)

            Trait_RaisedUniversalBoxEnabler.SetStage(500)
            Trait_RaisedEnlightenedBoxEnabler.SetStage(500)

            If(RAS_DisableStarborn.GetValueInt() == 1)
                Game.GetPlayer().RemovePerk(StarbornSkillCheck)
            EndIf

            If(!MQ101.IsRunning())
                (NewAtlantisToLodgeDoorREF as FrontDoorToLodgeScript).LodgeFrontDoorOpen = True
                NewAtlantisToLodgeDoorREF.BlockActivation(false)
            EndIf
        EndIf
    EndIf        
    RAS_ModVersion.SetValue(LastVersion)
EndFunction

