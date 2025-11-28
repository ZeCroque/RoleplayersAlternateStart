Scriptname RAS:NewGameManagerQuest:CustomArtifactScript extends ReferenceAlias

ReferenceAlias Property Lin Auto Const Mandatory
ReferenceAlias Property Heller Auto Const Mandatory
Quest Property MQ101 Auto Const Mandatory
Scene Property MQ101_001b_MiningWalkScene Auto Const Mandatory
Scene Property MQ101_002_LinSupervisorScene Auto Const Mandatory
Scene Property MQ101_004_WallDownScene Auto Const Mandatory
Armor Property Spacesuit_Miner_Helmet_Lin_NOTPLAYABLE Auto Const Mandatory
Armor Property Spacesuit_Miner_Helmet_Orange_Heller_NOTPLAYABLE Auto Const Mandatory
Weapon Property Crew_Elite_Sidestar Auto Const Mandatory
Weapon Property Crew_Elite_Cutter Auto Const Mandatory
Idle Property IdleArtifactTouch Auto Const Mandatory
Scene Property RAS_MQ101_005_FaceGenScene Auto Const Mandatory
Message Property MQ101ArtifactMineralBedMSG Auto Const Mandatory

Event OnActivate(ObjectReference akActionRef)
	;show the helper message if the player hasn't drilled out the mineral bed
	If Self.GetRef().GetCurrentDestructionStage() < 3
		MQ101ArtifactMineralBedMSG.Show()
	Else
        (MQ101 as MQ101Script).VSEnableLayer.DisablePlayerControls(ablooking=True, abFavorites=true, abCamSwitch=True)

        Actor PlayerREF= Game.GetPlayer()
        Actor HellerREF = Heller.GetActorRef()
        Actor LinREF = Lin.GetActorRef()

        MQ101.SetObjectiveCompleted(43)

        ;hide HUD
        Game.SetCharGenHUDMode(1)

        ;clear laser drill alias so the cutter can stack with other cutters
        (MQ101.GetAlias(27) as ReferenceAlias).Clear()

        ;clear tutorials
        Message.ClearHelpMessages()

        ;shut down any other scenes
        MQ101_001b_MiningWalkScene.Stop()
        MQ101_002_LinSupervisorScene.Stop()
        MQ101_004_WallDownScene.Stop()

        ;preload the area if we haven't already
        If MQ101.GetStageDone(5) == 0
            MQ101.SetStage(5)
        EndIf

        ;safety check - pull Heller out of animflavor
        HellerREF.ChangeAnimFlavor(None)

        ;remove helmets
        LinREF.UnequipItem(Spacesuit_Miner_Helmet_Lin_NOTPLAYABLE, absilent=true)
        HellerREF.UnequipItem(Spacesuit_Miner_Helmet_Orange_Heller_NOTPLAYABLE, absilent=true)

        ;re-equip weapons
        LinREF.EquipItem(Crew_Elite_Sidestar)
        HellerREF.EquipItem(Crew_Elite_Cutter)

        ;play animation
        If PlayerREF.IsWeaponDrawn()
            Utility.Wait(1.0)
        EndIf
        PlayerREF.PlayIdle(IdleArtifactTouch)

        ;give the animation a second to play
        Utility.Wait(4.0)

        ;next scene plays
        RAS_MQ101_005_FaceGenScene.Start()
    EndIf
EndEvent

Event OnDestructionStageChanged(int aiOldStage, int aiCurrentStage)
    If(aiCurrentStage >= 3)
        MQ101.SetStage(51)
    EndIf
EndEvent
