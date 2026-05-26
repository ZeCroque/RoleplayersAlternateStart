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
Quest Property RAS_MQReplacerQuest Mandatory Const Auto
Quest Property RAS_BrokenShipQuest Mandatory Const Auto
ObjectReference Property KreetMapMarker Mandatory Const Auto
Quest Property MQ401a Mandatory Const Auto
Quest Property MQ401 Mandatory Const Auto
Quest Property RAS_LocationSpawnPointFinderQuest Mandatory Const Auto
Keyword Property CurrentInteractionLinkedRefKeyword Mandatory Const Auto
Quest Property RAS_MQReplacerIntroQuest Mandatory Const Auto
GlobalVariable Property RAS_BrokenShipQuest_ShiptechRepairCost Mandatory Const Auto
Quest Property RAS_ShipwreckedRescueQuest Mandatory Const Auto

Event OnQuestInit()
    RAS_ModVersion.SetValue(RAS:Utility:ModInfo.GetModVersion())
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
        EndIf   
        If(RAS_ModVersion.GetValue() < 1.13)
            (RAS_ShipManagerQuest as RAS:ShipManagerQuest:ShipManagerQuestScript).InitFreeLanes()
        EndIf
        If(RAS_ModVersion.GetValue() < 1.15)
            (NewAtlantisToLodgeDoorREF as FrontDoorToLodgeScript).LodgeFrontDoorOpen = True ;skip base script

            ReferenceAlias LodgeDoorAlias = RAS_NewGameManagerQuest.GetAlias(52) as ReferenceAlias
            LodgeDoorAlias.RefillAlias()
            (LodgeDoorAlias as RAS:NewGameManagerQuest:FrontDoorToLodgeScript).SetWatchAnimationRequired(MQ101.IsRunning() && !MQ101.GetStageDone(1510))
        
            (RAS_MQReplacerQuest as RAS:MQReplacer:MQReplacerScript).InitArtifactExclusionList()

            If(Game.GetPlayer().HasPerk(TRAIT_UnwantedHero))
                If(MQ101Debug.GetValue() == 0)
                    If(!TraitUnwantedHero.IsRunning())
                        TraitUnwantedHero.Reset()
                        If(MQ101.IsCompleted())
                            TraitUnwantedHero.Start()
                        EndIf
                    EndIf    
                EndIf
            EndIf

            If(RAS_BrokenShipQuest.IsRunning())
                RAS:BrokenShipQuest:BrokenShipQuestScript brokenShipQuest = RAS_BrokenShipQuest as RAS:BrokenShipQuest:BrokenShipQuestScript
                SpaceshipReference brokenShip = brokenShipQuest.ShipAlias.GetShipReference()

                If(Game.GetPlayerHomeSpaceShip() == brokenShip)                                  
                    SQ_PlayerShipScript playerShipQuest = SQ_PlayerShip as SQ_PlayerShipScript
                    Int shipCount = playerShipQuest.PlayerShips.GetCount()        

                    Self.RegisterForRemoteEvent(playerShipQuest.PlayerShips, "OnAliasChanged")
                    SpaceshipReference newHomeShip = None
                    If(shipCount == 1)
                        (RAS_ShipManagerQuest as RAS:ShipManagerQuest:ShipManagerQuestScript).InitNoneShip()
                    Else      
                        Int i = 0
                        While(i < shipCount)
                            SpaceshipReference ownedShip = playerShipQuest.PlayerShips.GetAt(i) as SpaceshipReference
                            If(ownedShip !=  brokenShip)
                                playerShipQuest.ResetHomeShip(newHomeShip)
                                    
                                i = shipCount
                            EndIf
                        EndWhile
                    EndIf                  
                    playerShipQuest.RemovePlayerShip(brokenShip)
                    playerShipQuest.PlayerShip.ForceRefTo((RAS_ShipManagerQuest as RAS:ShipManagerQuest:ShipManagerQuestScript).RAS_NoneShipReference)
                EndIf                
            EndIf

            If(MQ101.GetStage() == 0)
                KreetMapMarker.SetMarkerVisibleOnStarMap(False)
            EndIf
        EndIf 
        If(RAS_ModVersion.GetValue() < 1.17)
            (RAS_NewGameManagerQuest as RAS:NewGameManagerQuest:NewGameManagerQuestScript).PlaceCustomTrigger()
            If(MQ401a.IsRunning() && !MQ401.IsRunning())
                MQ401a.Stop()
            EndIf
            If(RAS_BrokenShipQuest.IsRunning())
                RAS:BrokenShipQuest:BrokenShipQuestScript brokenShipQuest = RAS_BrokenShipQuest as RAS:BrokenShipQuest:BrokenShipQuestScript
                SpaceshipReference brokenShip = brokenShipQuest.ShipAlias.GetShipReference()
                brokenShip.Enable()
                brokenShip.SetLinkedRef((RAS_LocationSpawnPointFinderQuest as RAS:LocationSpawnPointFinder:LocationSpawnPointFinderQuestScript).GetShipMarker(), CurrentInteractionLinkedRefKeyword)
            EndIf
        EndIf  
        If(RAS_ModVersion.GetValue() < 1.20)
            (RAS_MQReplacerIntroQuest as RAS:MQReplacer:MQReplacerIntroQuestScript).RegisterForHunterQuest()
            
            RAS:ShipManagerQuest:ShipManagerQuestScript managerQuest = RAS_ShipManagerQuest as RAS:ShipManagerQuest:ShipManagerQuestScript
            If(managerQuest.PedestrianStart)
                managerQuest.RegisterForMonocleMenu()
            EndIf

            RAS_BrokenShipQuest.UpdateCurrentInstanceGlobal(RAS_BrokenShipQuest_ShiptechRepairCost)
            (RAS_BrokenShipQuest as RAS:BrokenShipQuest:BrokenShipQuestScript).RegisterForShipEvents()

            (RAS_ShipwreckedRescueQuest as RAS:ShipwreckedRescueQuest:ShipwreckedRescueQuestScript).RegisterForShipEvents()

            If(MQ101.IsCompleted())
                (RAS_NewGameManagerQuest as RAS:NewGameManagerQuest:NewGameManagerQuestScript).CustomArtifactDeposit.TryToDisable()
            EndIf
        EndIf    
    EndIf      
    RAS_ModVersion.SetValue(RAS:Utility:ModInfo.GetModVersion())
EndFunction

Event RefCollectionAlias.OnAliasChanged(RefCollectionAlias akSender, ObjectReference akObject, bool abRemove)
    If(abRemove)
        SpaceshipReference brokenShip = (RAS_BrokenShipQuest as RAS:BrokenShipQuest:BrokenShipQuestScript).ShipAlias.GetShipReference()
        If(akObject == brokenShip)
            brokenShip.Enable()
            brokenShip.SetLinkedRef((RAS_LocationSpawnPointFinderQuest as RAS:LocationSpawnPointFinder:LocationSpawnPointFinderQuestScript).GetShipMarker(), Game.GetForm(0x1940B) as Keyword)
            Self.UnregisterForRemoteEvent((SQ_PlayerShip as SQ_PlayerShipScript).PlayerShips, "OnAliasChanged")
        EndIf
    EndIf
EndEvent
