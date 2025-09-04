Scriptname RAS_NewGameManagerQuestScript extends Quest Conditional

Quest Property MQ101 Mandatory Const Auto
Quest Property MQ101PostQuest Mandatory Const Auto
Quest Property MQ102 Mandatory Const Auto
Quest Property MQ104B Mandatory Const Auto
Quest Property RAS_MQ104B Mandatory Const Auto
ActorValue Property PlayerUnityTimesEntered Auto Const mandatory
ObjectReference Property LodgeStartMarker Auto Const mandatory
ObjectReference Property VascoREF Auto Const Mandatory
Quest Property FFLodge01 Mandatory Const Auto
Quest Property City_NA_Aquilus01 Mandatory Const Auto
Perk Property Crew_Ship_AneutronicFusion Mandatory Const Auto
Perk Property Crew_Ship_Shields Mandatory Const Auto
Perk Property Crew_Ship_Weapons_EM Mandatory Const Auto
Faction Property ConstellationFaction Mandatory Const Auto
Faction Property PotentialCrewFaction Mandatory Const Auto
Key Property LodgeKey Auto Const Mandatory
ActorValue Property PlayerXPBonusMult Auto Const Mandatory
ObjectReference Property NewAtlantisToLodgeDoorREF Mandatory Const Auto
ImageSpaceModifier Property StayBlack Mandatory Const Auto
ImageSpaceModifier Property FadeFromBlack Mandatory Const Auto
ObjectReference Property RAS_TmpCellMarkerREF Mandatory Const Auto
GlobalVariable Property MQProgress Mandatory Const Auto
ObjectReference Property RAS_GameStartCellMarkerREF Mandatory Const Auto
Message Property RAS_ChooseStartTypeMessage Mandatory Const Auto
ObjectReference Property VecteraMineStarMarker Auto Const Mandatory
ObjectReference Property RAS_ChooseStartCellMarkerREF Mandatory Const Auto
ReferenceAlias Property VecteraWorldCompanionCommentTrigger Mandatory Const Auto
ReferenceAlias Property VecteraMineCompanionCommentTrigger Mandatory Const Auto
ReferenceAlias Property MineWallBreakable Mandatory Const Auto
Quest Property MQ_TutorialQuest_Misc04 Mandatory Const Auto
ActorValue Property RAS_AlternateStart Mandatory Const Auto
GlobalVariable Property MQ101Debug Mandatory Const Auto
GlobalVariable Property MQ401_VariantCurrent Mandatory Const Auto
Message Property RAS_MQ101DebugModifiedMessage Mandatory Const Auto
Quest Property MQ401 Mandatory Const Auto
Quest Property RAS_MQ101 Mandatory Const Auto
GlobalVariable Property MQ401_SkipMQ Mandatory Const Auto
Quest Property MQ402 Mandatory Const Auto
Quest Property COM_Companion_SamCoe_CoraCoe_Handler Mandatory Const Auto
Faction Property EyeBoardingFaction Mandatory Const Auto
ObjectReference Property RAS_StarbornStuffTmpContainer Mandatory Const Auto
ObjectReference Property Frontier_ModularREF Mandatory Const Auto
FormList Property RAS_TmpItemsToEquipBack Mandatory Const Auto
GlobalVariable Property MQ101SaveOff Mandatory Const Auto
ObjectReference Property MQPlayerStarbornShipREF Mandatory Const Auto
ReferenceAlias Property StarbornGuardianSeat Mandatory Const Auto
Quest Property DialogueShipServices Mandatory Const Auto
ReferenceAlias Property StartingLocationActivatorAlias Mandatory Const Auto
ReferenceAlias Property StartingGearTerminalAlias Mandatory Const Auto
ReferenceAlias Property HomeChoosingActivatorAlias Mandatory Const Auto
ReferenceAlias Property LevelManagerActivatorAlias Mandatory Const Auto
ReferenceAlias Property CharGenActivatorAlias Mandatory Const Auto
ReferenceAlias Property UnityShipServiceTechAlias Mandatory Const Auto
ReferenceAlias Property NarrativeAdjustmentsActivatorAlias Mandatory Const Auto
LocationAlias Property StartingLocationAlias Mandatory Const Auto
ReferenceAlias Property StartingLocationMapMarkerAlias Mandatory Const Auto
ReferenceAlias Property StartingLocationShipMarkerAlias Mandatory Const Auto
ReferenceAlias Property StartingLocationShipTechAlias Mandatory Const Auto

InputEnableLayer Property InputLayer Auto
ObjectReference Property FastTravelTarget Auto 
SpaceshipReference Property RAS_NoneShipReference Auto
Bool Property PedestrianStart Auto Conditional
Bool Property StarbornStart Auto Conditional
Bool Property StarbornVanillaStart Auto Conditional

Event OnQuestInit()
  If MQ101.GetStageDone(105) == True || (Game.GetPlayer().GetValue(PlayerUnityTimesEntered) > 0 && Game.GetPlayer().GetValue(RAS_AlternateStart) == 0)
    Stop()
  ElseIf(MQ101Debug.GetValue() != 5.0)
    RAS_MQ101DebugModifiedMessage.Show()
    Stop()
  Else
    StayBlack.Apply() 
    Game.HideHudMenus()
    Game.SetInChargen(True, True, False)
    InputLayer = InputEnableLayer.Create()
    InputLayer.DisablePlayerControls()
    If(Game.GetPlayer().GetValue(PlayerUnityTimesEntered) > 0 && Game.GetPlayer().GetValue(RAS_AlternateStart))
      StarbornStart = True
      StarbornGuardianSeat.GetReference().Disable()
      FastTravelTarget = MQPlayerStarbornShipREF

      Self.RegisterForRemoteEvent(MQ401, "OnStageSet")
      Self.RegisterForRemoteEvent(MQPlayerStarbornShipREF.GetCurrentLocation(), "OnLocationLoaded")
    Else
      FastTravelTarget = RAS_ChooseStartCellMarkerREF
      Game.FastTravel(RAS_GameStartCellMarkerREF) 
    EndIf
  EndIf

  ;Register for activators
  Self.RegisterForRemoteEvent(StartingLocationActivatorAlias, "OnActivate")
  Self.RegisterForRemoteEvent(StartingGearTerminalAlias, "OnActivate")
  Self.RegisterForRemoteEvent(HomeChoosingActivatorAlias, "OnActivate")
  Self.RegisterForRemoteEvent(LevelManagerActivatorAlias, "OnActivate")
  Self.RegisterForRemoteEvent(CharGenActivatorAlias, "OnActivate")
  Self.RegisterForRemoteEvent(UnityShipServiceTechAlias, "OnActivate")
  Self.RegisterForRemoteEvent(NarrativeAdjustmentsActivatorAlias, "OnActivate")
EndEvent

Event OnStageSet(int auiStageID, int auiItemID)
  If(auiStageID == 5)
    If(RAS_ChooseStartTypeMessage.Show() == 0)
      FastTravelTarget = VecteraMineStarMarker
      Game.FastTravel(RAS_TmpCellMarkerREF)
      Game.ForceFirstPerson()
      (MQ101 as mq101script).VSEnableLayer.EnableCamSwitch(false)
      MQ101.SetActive()
      MQ101.SetObjectiveDisplayed(5, False, True)
      SetObjectiveCompleted(10)
      CompleteQuest()
    Else
      Game.GetPlayer().SetValue(RAS_AlternateStart, 1)
      (MQ101 as mq101script).VSEnableLayer.Delete()
      Game.PrecacheCharGen()
      Self.RegisterForMenuOpenCloseEvent("ChargenMenu")
      Game.ShowRaceMenu(None, 0, None, None, None) 
    EndIf
  EndIf
EndEvent

Event OnMenuOpenCloseEvent(String asMenuName, Bool abOpening)
  If (asMenuName == "ChargenMenu" && abOpening == False)
    Self.UnregisterForMenuOpenCloseEvent("ChargenMenu")

    SetStage(10) ;Show choose start objective and targets
    ;Locks the lodge until we start the custom quest
    NewAtlantisToLodgeDoorREF.SetLockLevel(254)
    NewAtlantisToLodgeDoorREF.Lock()

    HookMQ()
  EndIf
EndEvent

Function HookMQ()
    Game.GetPlayer().SetValue(PlayerXPBonusMult, 0) ;Prevent level up

    ;This will ensure we don't see the quest in the log
    MQ101.SetObjectiveDisplayed(5, False, True) ;Vanilla
    MQ101.SetObjectiveDisplayed(170, False, True) ;Starborn

    ;Hooking quests to shutdown/silence
    Self.RegisterForRemoteEvent(MQ101, "OnStageSet")
    Self.RegisterForRemoteEvent(MQ101PostQuest, "OnQuestStarted")
    Self.RegisterForRemoteEvent(MQ_TutorialQuest_Misc04, "OnQuestStarted")
    Self.RegisterForRemoteEvent(FFLodge01, "OnStageSet")
    Self.RegisterForRemoteEvent(MQ102, "OnStageSet") ;Also used to trigger RAS_MQ104B

    ;We need to stop the quest to prevent scenes to occur, but we need to have this stage done for constellation dialogs to work
    ;So we set the final stage but we will undo all the changes once the final stage is set (we'll set them back later)
    MQ101.SetStage(1335) ;disable NA ship tech special greeting
    MQ101.SetStage(1800) 
    MQ101.Stop()

    ;Add required triggers from stages we skipped
    City_NA_Aquilus01.Start()
    MQProgress.SetValue(2)

    ;Prevent the real MQ104B to happen and wait for closing stage to undo the changes in RAS_MQ104B stage 5 fragment
    Self.RegisterForRemoteEvent(MQ104B, "OnStageSet")
    MQ104B.Start()
    MQ104B.SetStage(390) ;Prevents Sarah commentary
    MQ104B.Stop()
    
    ;Prevent companion comments about the mining operation
    VecteraWorldCompanionCommentTrigger.GetReference().Disable()
    VecteraMineCompanionCommentTrigger.GetReference().Disable()

    ;Register to undo drill anim each time
    Self.RegisterForRemoteEvent(MineWallBreakable.GetReference(), "OnCellLoad")

    ;Register to remove unwanted vasco trigger
    Self.RegisterForRemoteEvent(NewAtlantisToLodgeDoorREF, "OnCellLoad")
EndFunction

Event Quest.OnStageSet(Quest akSender, Int auiStageID, Int auiItemID)
  MQ101SaveOff.SetValue(0) ;Prevent saving in NG+
  Utility.Wait(1.0) ;meant to lose the race with the fragment that runs in parallel, unfortunately bugprone
  If(akSender == MQ101 && auiStageID == 9000)
    Game.FastTravel(RAS_TmpCellMarkerREF)

    Actor PlayerREF = Game.GetPlayer()
    PlayerREF.RemoveFromFaction(ConstellationFaction)
    PlayerREF.SetValue(PlayerXPBonusMult, 1)
    PlayerREF.RemoveAllItems()
    PlayerREF.RemoveItem(LodgeKey) ;for some reason RemoveAllItems doesn't remove this

    Actor Vasco = VascoREF as Actor
    Vasco.RemoveFromFaction(PotentialCrewFaction)
    Vasco.RemovePerk(Crew_Ship_AneutronicFusion)
    Vasco.RemovePerk(Crew_Ship_Shields)
    Vasco.RemovePerk(Crew_Ship_Shields)
    Vasco.RemovePerk(Crew_Ship_Weapons_EM)

    If(StarbornVanillaStart)
      ;Restore inventory silently
      Form[] ItemsToEquipBack = RAS_TmpItemsToEquipBack.GetArray()
      Int i = 0
      While(i < ItemsToEquipBack.Length)
        Game.GetPlayer().EquipItem(ItemsToEquipBack[i], true)
        RAS_StarbornStuffTmpContainer.RemoveItem(ItemsToEquipBack[i])
        i = i + 1
      EndWhile
      i = 0
      Int ItemCount = RAS_StarbornStuffTmpContainer.GetItemCount()
      While(i < ItemCount)
        Game.GetPlayer().AddItem(akItemToAdd = RAS_StarbornStuffTmpContainer.DropFirstObject(), abSilent = True)
        i = i + 1
      EndWhile
    
      Game.RemovePlayerOwnedShip(Frontier_ModularREF as SpaceshipReference)
    EndIf
  ElseIf(akSender == FFLodge01 && auiStageID == 10)
    FFLodge01.SetObjectiveDisplayed(10, false, true)
    Self.UnregisterForRemoteEvent(FFLodge01, "OnStageSet")
  ElseIf(akSender == MQ102)
    If(auiStageID == 10)
      MQ102.SetObjectiveDisplayed(10, false, true)
    ElseIf(auiStageID == 1150)
      RAS_MQ104B.SetStage(10)
      Self.UnregisterForRemoteEvent(MQ102, "OnStageSet")
    Endif
  ElseIf(akSender == MQ104B)
    If(auiStageID == 390)
      MQ104B.SetObjectiveDisplayed(115, False, True)
    ElseIf(auiStageID == 2000)
      RAS_MQ104B.SetStage(0)
      Self.UnregisterForRemoteEvent(MQ104B, "OnStageSet")
    EndIf
  ElseIf(akSender == MQ401 )
    If(auiStageID == 110)    
      SetObjectiveDisplayed(10, False, True)
      If(MQ401_VariantCurrent.GetValue() == 0)
        MQ401_VariantCurrent.SetValue(1) ;Changing at this point wont impact universe output but will prevent lodge scene
        StarbornVanillaStart = True

        ;Put starborn items aside to prevent them from being erased with MQ101 quest rewards by hooks
        Game.GetPlayer().RemoveAllItems(RAS_StarbornStuffTmpContainer)
        
        ;Register hooks
        HookMQ()

        ;Setting up mq replacer and make sure we stop listening to unequip events on alias
        RAS_MQ101.SetStage(25)
        RAS_MQ101.SetActive()
      Else
        Game.FastTravel(RAS_TmpCellMarkerREF)
      EndIf
    ElseIf(auiStageID == 300)
      RAS_MQ101.CompleteAllObjectives()
      RAS_MQ101.SetStage(2100)
      MQ401_SkipMQ.SetValueInt(1)
      MQ102.Stop()
      MQ402.SetStage(10)

      COM_Companion_SamCoe_CoraCoe_Handler.Start()
      If(MQ401.GetStageDone(300))
        FFLodge01.Stop()
      Else
        FFLodge01.SetObjectiveDisplayed(10, true, true)
      EndIf

      Actor PlayerREF = Game.GetPlayer()
      PlayerREF.AddToFaction(ConstellationFaction)
      PlayerREF.AddItem(LodgeKey)
      PlayerREF.addtoFaction(EyeBoardingFaction)

      Actor Vasco = VascoREF as Actor
      Vasco.SetFactionRank(PotentialCrewFaction, 1)
      Vasco.AddPerk(Crew_Ship_AneutronicFusion)
      Vasco.AddPerk(Crew_Ship_Shields)
      Vasco.AddPerk(Crew_Ship_Shields)
      Vasco.AddPerk(Crew_Ship_Weapons_EM)

      Game.AddPlayerOwnedShip(Frontier_ModularREF as SpaceshipReference)
    EndIf
  EndIf
EndEvent

Event Quest.OnQuestStarted(Quest akSender)
  If(akSender == MQ101PostQuest)
    MQ101PostQuest.Stop() ;removes unwanted dialogs
    Self.UnregisterForRemoteEvent(MQ101PostQuest, "OnQuestStarted")
  ElseIf(akSender == MQ_TutorialQuest_Misc04)
    MQ_TutorialQuest_Misc04.Stop()
    Self.UnregisterForRemoteEvent(MQ_TutorialQuest_Misc04, "OnQuestStarted")
  EndIf
EndEvent

Event ObjectReference.OnCellLoad(ObjectReference akSender)
  If(akSender == NewAtlantisToLodgeDoorREF)
    (Game.GetFormFromFile(0x110644, "Starfield.esm") as ObjectReference).Disable() ;Disable warning creating MQ101 trigger
    
    Self.UnregisterForRemoteEvent(NewAtlantisToLodgeDoorREF, "OnCellLoad")
  ElseIf(akSender == MineWallBreakable.GetReference())
    Utility.Wait(1) ;Wait for drill anim to end
    MineWallBreakable.GetReference().PlayAnimation("Stage1")
  EndIf
EndEvent

Event Location.OnLocationLoaded(Location akSender)
  StarbornGuardianSeat.GetReference().Enable()
  
  FadeFromBlack.Apply()
  Utility.Wait(0.2)
  StayBlack.Remove()
  InputLayer.Delete()

  Game.SetInChargen(False, False, False) 
  Game.RequestSave()

  If(StarbornVanillaStart == False)
    Stop()
  EndIf

  Self.UnregisterForRemoteEvent(MQPlayerStarbornShipREF.GetCurrentLocation(), "OnLocationLoaded")
EndEvent

Function SetupPlayerShip(SpaceshipReference akShip)
  RAS_NoneShipReference = None
  PedestrianStart = False
  InputLayer.Delete()
  DialogueShipServices.Reset()
  DialogueShipServices.Start()
  akShip.SetExteriorLoadDoorInaccessible(False)
EndFunction

Event ReferenceAlias.OnActivate(ReferenceAlias akSender, ObjectReference akActionRef)
    If(akSender == StartingLocationActivatorAlias)
      SetStage(11)
      SetObjectiveCompleted(10)
    ElseIf(akSender == StartingGearTerminalAlias)
      SetObjectiveCompleted(13)
    ElseIf(akSender == HomeChoosingActivatorAlias)
      SetObjectiveCompleted(11)
    ElseIf(akSender ==  LevelManagerActivatorAlias)
      SetObjectiveCompleted(14)
    ElseIf(akSender == CharGenActivatorAlias)
      SetObjectiveCompleted(16)
    ElseIf(akSender == UnityShipServiceTechAlias)
      SetObjectiveCompleted(12)
    ElseIf(akSender == NarrativeAdjustmentsActivatorAlias)
      SetObjectiveCompleted(15)
 EndIf
EndEvent