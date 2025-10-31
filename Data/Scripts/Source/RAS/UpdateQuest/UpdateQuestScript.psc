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
Quest Property SQ_PlayerShip Mandatory Const Auto
Message Property RAS_PlaceholderDebugMessage Mandatory Const Auto

Float LastVersion = 1.04

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

        ;Debug
        SQ_PlayerShipScript playerShipQuest = SQ_PlayerShip as SQ_PlayerShipScript
        RAS:ShipManagerQuest:ShipManagerQuestScript rasShipScript = RAS_ShipManagerQuest as RAS:ShipManagerQuest:ShipManagerQuestScript
        If(playerShipQuest.PlayerShip.GetShipReference() == rasShipScript.RAS_NoneShipReference)
            Int i = 0
            While(i < playerShipQuest.PlayerShips.GetCount())
                SpaceshipReference ship = playerShipQuest.PlayerShips.GetAt(i) as SpaceshipReference
                If(ship != rasShipScript.RAS_NoneShipReference)
                    playerShipQuest.ResetHomeShip(ship)
                    RAS_PlaceholderDebugMessage.Show()
                    Return
                EndIf
                i += 1
            EndWhile
        EndIf
    EndIf        
    RAS_ModVersion.SetValue(LastVersion)
EndFunction

