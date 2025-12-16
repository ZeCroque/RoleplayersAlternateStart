Scriptname RAS:NewGameManagerQuest:NewGameManagerQuestScript extends Quest Conditional

Quest Property MQ101 Mandatory Const Auto
Quest Property MQ101PostQuest Mandatory Const Auto
Quest Property MQ102 Mandatory Const Auto
Quest Property MQ104B Mandatory Const Auto
Quest Property RAS_MQ104B Mandatory Const Auto
ActorValue Property PlayerUnityTimesEntered Auto Const mandatory
ObjectReference Property VascoREF Auto Const Mandatory
Quest Property FFLodge01 Mandatory Const Auto
Quest Property City_NA_Aquilus01 Mandatory Const Auto
Quest Property TraitQuest Mandatory Const Auto
Quest Property TraitUnwantedHero Mandatory Const Auto
Perk Property Crew_Ship_AneutronicFusion Mandatory Const Auto
Perk Property Crew_Ship_Shields Mandatory Const Auto
Perk Property Crew_Ship_Weapons_EM Mandatory Const Auto
Faction Property ConstellationFaction Mandatory Const Auto
Faction Property PotentialCrewFaction Mandatory Const Auto
Key Property LodgeKey Auto Const Mandatory
ActorValue Property PlayerXPBonusMult Auto Const Mandatory
ObjectReference Property NewAtlantisToLodgeDoorREF Mandatory Const Auto
ImageSpaceModifier Property StayBlack Mandatory Const Auto
ObjectReference Property RAS_TmpCellMarkerREF Mandatory Const Auto
GlobalVariable Property MQProgress Mandatory Const Auto
ObjectReference Property RAS_GameStartCellMarkerREF Mandatory Const Auto
Message Property RAS_ChooseStartTypeMessage Mandatory Const Auto
ObjectReference Property VecteraMineStarMarker Auto Const Mandatory
ObjectReference Property RAS_ChooseStartCellMarkerREF Mandatory Const Auto
ReferenceAlias Property VecteraWorldCompanionCommentTrigger Mandatory Const Auto
ReferenceAlias Property VecteraMineCompanionCommentTrigger Mandatory Const Auto
ReferenceAlias Property MineWallBreakable Mandatory Const Auto
ReferenceAlias Property MineBoringMachine Mandatory Const Auto
ReferenceAlias Property CharGenFurniture Auto Const Mandatory
ReferenceAlias Property ArtifactDeposit Mandatory Const Auto
ReferenceAlias Property CustomArtifactDeposit Mandatory Const Auto
ObjectReference Property MQ101_BoringCollision Const Mandatory Auto
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
ObjectReference Property RAS_StartingStuffContainer Mandatory Const Auto
ObjectReference Property Frontier_ModularREF Mandatory Const Auto
FormList Property RAS_TmpItemsToEquipBack Mandatory Const Auto
GlobalVariable Property MQ101SaveOff Mandatory Const Auto
ReferenceAlias Property StarbornGuardianSeat Mandatory Const Auto
ReferenceAlias Property StartingLocationActivatorAlias Mandatory Const Auto
ReferenceAlias Property StartingGearTerminalAlias Mandatory Const Auto
ReferenceAlias Property HomeChoosingActivatorAlias Mandatory Const Auto
ReferenceAlias Property LevelManagerActivatorAlias Mandatory Const Auto
ReferenceAlias Property CharGenActivatorAlias Mandatory Const Auto
ReferenceAlias Property UnityShipServiceTechAlias Mandatory Const Auto
ReferenceAlias Property NarrativeAdjustmentsActivatorAlias Mandatory Const Auto
ReferenceAlias Property MQDelayTerminalAlias Mandatory Const Auto
ReferenceAlias Property InvalidatedTerminal Mandatory Const Auto
Quest Property TraitKidStuff Mandatory Const Auto
Quest Property TraitStarterHome Mandatory Const Auto
Perk Property PERK_StarterHome Mandatory Const Auto
ObjectReference Property LC001VecteraLiftDoor Mandatory Auto Const
Activator Property MQ01_Artifact01_Activator Mandatory Const Auto
ObjectReference Property MQ101_LGT_A Auto Const Mandatory
ObjectReference Property MQ101_LGT_B Auto Const Mandatory
ReferenceAlias Property Heller Mandatory Const Auto
ReferenceAlias Property Lin Mandatory Const Auto
ReferenceAlias Property Barrett Mandatory Const Auto
Activator Property RAS_PlayerStuffActivator Mandatory Const Auto
ReferenceAlias Property PlayerStuffActivatorAlias Mandatory Const Auto
Quest Property RAS_PlayerStuffPickUpQuest Mandatory Const Auto
Scene Property MQ101_VascoShipServicesScene Mandatory Const Auto
Quest Property RAS_MQReplacerQuest Mandatory Const Auto
Armor Property Spacesuit_Constellation_01 Mandatory Const Auto
Armor Property Spacesuit_Constellation_Backpack_01 Mandatory Const Auto
Armor Property Spacesuit_Constellation_Helmet_01 Mandatory Const Auto
Armor Property Clothes_Miner_UtilitySuit Mandatory Const Auto
ActorValue Property RAS_MinerStart Mandatory Const Auto
ObjectReference Property MQ104B_LinSandbox_CenterMarker Auto Const Mandatory
ObjectReference Property ArtifactNotYetTakenEnableMarker Auto Const Mandatory
ObjectReference Property VecteraInteriorNPCEnableMarker Mandatory Const Auto
ObjectReference Property LC003_InteriorBaseActorEnableMarker Auto Const Mandatory
Message Property Tutorial_NewGamePlusMSGBox Auto Const Mandatory
Quest Property MQ305 Mandatory Const Auto
Quest Property RAS_ShipManagerQuest Mandatory Const Auto
Outfit Property Outfit_Starborn Auto Const Mandatory
Perk Property StarbornSkillCheck Auto Const Mandatory
GlobalVariable Property RAS_DisableStarborn Mandatory Const Auto

InputEnableLayer Property InputLayer Auto Hidden
ObjectReference Property FastTravelTarget Auto Hidden
Bool Property StarbornStart Auto Conditional
Bool Property StarbornVanillaStart Auto Conditional

CustomEvent ConfigurationChanged

Int UnityCount = 0

Function LockPlayer()
  StayBlack.Apply() 
  Game.HideHudMenus()

  Game.SetInChargen(True, True, False)
  InputLayer = InputEnableLayer.Create()
  InputLayer.DisablePlayerControls()
EndFunction

Function PreventMQ101FirstStage()
  UnityCount = Game.GetPlayer().GetValue(PlayerUnityTimesEntered) as Int
  If(UnityCount > 0)  
    Game.GetPlayer().SetValue(PlayerUnityTimesEntered, 0)
    Self.RegisterForRemoteEvent(MQ101, "OnStageSet")        
  EndIf    
  MQ101Debug.SetValueInt(11)
EndFunction

Function RegisterForChargen()
  Self.RegisterForMenuOpenCloseEvent("ChargenMenu")
EndFunction

Function InitCustomStart()  
  Game.GetPlayer().SetValue(RAS_AlternateStart, 1)
  SetStage(10)

  Self.RegisterForRemoteEvent(StartingLocationActivatorAlias, "OnActivate")
  Self.RegisterForCustomEvent((StartingLocationActivatorAlias.GetRef() as RAS:NewGameConfiguration:DynamicTerminals:StartingLocation:StartingLocationActivatorScript).RAS_StartingLocationTerminalREF as RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript, "SelectionChanged")
  Self.RegisterForRemoteEvent(StartingGearTerminalAlias, "OnActivate")
  Self.RegisterForRemoteEvent(HomeChoosingActivatorAlias, "OnActivate")
  Self.RegisterForCustomEvent((HomeChoosingActivatorAlias.GetRef() as RAS:NewGameConfiguration:DynamicTerminals:HomeChoosing:HomeChoosingActivatorScript).RAS_HomeChoosingTerminalREF as RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript, "SelectionChanged")
  Self.RegisterForRemoteEvent(LevelManagerActivatorAlias, "OnActivate")
  Self.RegisterForRemoteEvent(CharGenActivatorAlias, "OnActivate")
  Self.RegisterForRemoteEvent(UnityShipServiceTechAlias, "OnActivate")
  Self.RegisterForCustomEvent(UnityShipServiceTechAlias.GetActorRef() as RAS:NewGameConfiguration:ShipVendorScript, "ShipChanged")
  Self.RegisterForRemoteEvent(NarrativeAdjustmentsActivatorAlias, "OnActivate")
  Self.RegisterForCustomEvent(NarrativeAdjustmentsActivatorAlias.GetRef() as RAS:NewGameConfiguration:DynamicTerminals:NarrativeAdjustments:NarrativeAdjustmentsActivatorScript, "SelectionChanged")

  If(StarbornStart)
      (RAS_ShipManagerQuest as RAS:ShipManagerQuest:ShipManagerQuestScript).InitStarbornShip()

      ; give the player the right starting gear
      Game.GetPlayer().SetOutfit(Outfit_Starborn)
      Game.GetPlayer().AddPerk(StarbornSkillCheck)
  Else
      (RAS_ShipManagerQuest as RAS:ShipManagerQuest:ShipManagerQuestScript).InitNoneShip()
  EndIf
EndFunction

Function InitVanillaStart()  
  InputLayer.Delete()

  Self.RegisterForRemoteEvent(MQ101, "OnStageSet")
  MQ101.Start()
EndFunction

Function HookVanillaMQ101()
  Game.GetPlayer().SetValue(RAS_MinerStart, 1.0)
  RAS_MQReplacerQuest.Stop()

  CustomArtifactDeposit.ForceRefTo(ArtifactDeposit.GetReference().PlaceAtMe(MQ01_Artifact01_Activator))
  ArtifactDeposit.TryToDisable()

  NewAtlantisToLodgeDoorREF.Unlock()

  Self.RegisterForRemoteEvent(MQ101_VascoShipServicesScene, "OnEnd")
EndFunction

Event Scene.OnEnd(Scene akSender)
  MQ101.SetStage(1335)
  MQ101.SetStage(1340)
  Self.UnregisterForRemoteEvent(MQ101_VascoShipServicesScene, "OnEnd")
EndEvent

Function SetupVanillaCharGen()    
  Actor HellerREF = Heller.GetActorRef()
  If(!RegisterForAnimationEvent(HellerREF, "CharacterGenStart"))
    RegisterForRemoteEvent(HellerREF, "OnLoad")
  EndIf
EndFunction

Event ObjectReference.OnLoad(ObjectReference akSender)
	Actor HellerREF = Heller.GetActorRef()
	RegisterForAnimationEvent(HellerREF, "CharacterGenStart")
  ObjectReference playerStuffTarget = (Game.GetForm(0x66872) as ObjectReference)
  PlayerStuffActivatorAlias.ForceRefTo(playerStuffTarget.PlaceAtMe(RAS_PlayerStuffActivator))
  playerStuffTarget.Disable()
EndEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
  StartVanillaCharGen()
EndEvent

Function StartVanillaCharGen()
  Actor PlayerREF = Game.GetPlayer()
	Game.FadeOutGame(True, True, 0.0, 0.1, True) ;fade out
	Utility.Wait(0.5)	;wait for the fade
	MQ101_LGT_A.DisableNoWait()
	MQ101_LGT_B.EnableNoWait() ;swap lights
	RegisterForMenuOpenCloseEvent("ChargenMenu")
	RegisterForRemoteEvent(PlayerREF, "OnGetUp")
	CharGenFurniture.GetRef().Activate(Game.GetPlayer()) ;get the player out of furniture
EndFunction

Event Actor.OnGetUp(Actor akSender, ObjectReference akFurniture)
	Actor PlayerREF = Game.GetPlayer()
	Game.FadeOutGame(False, True, 0.5, 0.1) ;fade in so we see the char menu
	Game.ShowRaceMenu(uiMode=2)
	CharGenFurniture.getRef().BlockActivation(True, True)
	UnRegisterForRemoteEvent(PlayerREF, "OnGetUp")
EndEvent

Event OnStageSet(int auiStageID, int auiItemID)
  If(auiStageID == 5)
    Game.GetPlayer().RemoveItem(Spacesuit_Constellation_01, abSilent = True)
    Game.GetPlayer().RemoveItem(Spacesuit_Constellation_Backpack_01, abSilent = True)
    Game.GetPlayer().RemoveItem(Spacesuit_Constellation_Helmet_01, abSilent = True)
    Game.GetPlayer().RemoveItem(Clothes_Miner_UtilitySuit, abSilent = True)

    SetObjectiveCompleted(10)
    CompleteQuest()      
    Stop()

    If(StarbornStart && Game.GetPlayer().GetValueInt(RAS_MinerStart) == 0)
      Self.RegisterForRemoteEvent(MQ401, "OnStageSet")
    EndIf

    InitVanillaStart()
  EndIf
EndEvent

Event OnMenuOpenCloseEvent(String asMenuName, Bool abOpening)
  If (asMenuName == "ChargenMenu" && abOpening == False)
    Self.UnregisterForMenuOpenCloseEvent("ChargenMenu")
    If(GetStage() == 10)
      Game.FastTravel(RAS_ChooseStartCellMarkerREF)
    Else
      MQ101.SetStage(105)
      RAS_PlayerStuffPickUpQuest.Start()
    EndIf
  EndIf
EndEvent

Function CustomStartSetup()
  City_NA_Aquilus01.Start()
  MQProgress.SetValue(2)
  TraitQuest.Start()
  TraitUnwantedHero.Stop()

  If(TraitKidStuff.IsRunning())
    TraitKidStuff.SetStageNoWait(25)
  EndIf

  ; If the player has the Starter Home trait, queue up the quest
  If (Game.GetPlayer().HasPerk(PERK_StarterHome))
    TraitStarterHome.SetStageNoWait(100)
  Else
    TraitStarterHome.Stop()
  EndIf

  LC001VecteraLiftDoor.SetLockLevel(254)
  LC001VecteraLiftDoor.Lock()

  ;Locks the lodge until we start the custom quest
  NewAtlantisToLodgeDoorREF.SetLockLevel(254)
  NewAtlantisToLodgeDoorREF.Lock()
EndFunction

Function HookMQ()
  ;Setting some vanilla triggers for mod compat
  MQ101.SetStage(310) ;Watch added
  MQ101.SetStage(1310) ;New atlantis landing
  MQ101.SetObjectiveDisplayed(170, False, True)
  MQ101.SetStage(1810) ;Stopping

  Self.RegisterForRemoteEvent(MQ102, "OnStageSet") ;Used to trigger RAS_MQ104B

  ;Prevent the real MQ104B to happen and wait for closing stage to undo the changes in RAS_MQ104B stage 5 fragment
  Game.GetPlayer().SetValue(PlayerXPBonusMult, 0) ;Prevent level up
  Self.RegisterForRemoteEvent(MQ104B, "OnStageSet")
  MQ104B.Start()
  MQ104B.SetStage(390) ;Prevents Sarah commentary
  MQ104B.Stop()
  Game.GetPlayer().SetValue(PlayerXPBonusMult, 1)
  
  ;Prevent companion comments about the mining operation
  VecteraWorldCompanionCommentTrigger.GetReference().Disable()
  VecteraMineCompanionCommentTrigger.GetReference().Disable()

  ;Register to open drill wall and disable collision and artifact
  Self.RegisterForRemoteEvent(MineWallBreakable.GetReference(), "OnCellLoad")
  MQ101_BoringCollision.DisableNoWait()
  ArtifactDeposit.TryToDisableNoWait()

  ;Register to remove unwanted vasco trigger  
  Self.RegisterForRemoteEvent(NewAtlantisToLodgeDoorREF, "OnCellLoad")  

  ;Prevent watch anim  
  (NewAtlantisToLodgeDoorREF as FrontDoorToLodgeScript).LodgeFrontDoorOpen = True
EndFunction

Function DisableStarborn()
  UnityCount = Game.GetPlayer().GetValueInt(PlayerUnityTimesEntered)
  Game.GetPlayer().SetValue(PlayerUnityTimesEntered, 0.0)
  Self.RegisterForRemoteEvent(MQ305, "OnStageSet")
EndFunction

Function RestoreItems()
  Form[] ItemsToEquipBack = RAS_TmpItemsToEquipBack.GetArray()
  Int i = 0
  While(i < ItemsToEquipBack.Length)
    Game.GetPlayer().EquipItem(ItemsToEquipBack[i], true)
    RAS_StartingStuffContainer.RemoveItem(ItemsToEquipBack[i])
    i = i + 1
  EndWhile
  While(RAS_StartingStuffContainer.GetItemCount() > 0)    
    ObjectReference itemRef = RAS_StartingStuffContainer.DropFirstObject()
    Game.GetPlayer().AddItem(itemRef, abSilent = True)
    Int currentItemCount = RAS_StartingStuffContainer.GetItemCount(itemRef.GetBaseObject())
    If(currentItemCount)
      RAS_StartingStuffContainer.RemoveItem(itemRef.GetBaseObject(), currentItemCount, True)
      Game.GetPlayer().AddItem(itemRef, currentItemCount, abSilent = True)
    EndIf
  EndWhile
EndFunction

Function CustomStarbornStartSetup()
  If(MQ401_VariantCurrent.GetValue() == 0)  
    StarbornVanillaStart = True

    ;If player is not a miner, register hooks
    If(Game.GetPlayer().GetValue(RAS_MinerStart) == 0)
      Self.RegisterForRemoteEvent(MQ401, "OnStageSet")
    EndIf
  EndIf

  ;Init the game
  Tutorial_NewGamePlusMSGBox.Show()
  Game.SetInChargen(False, False, False)

  ;Setup MQ
  PreventMQ101FirstStage()  
  MQ101.Start()  
  MQ401.SetStage(10)
  MQProgress.SetValue(2)

  ;Start other quests
  City_NA_Aquilus01.Start()
  TraitQuest.Start()

  ;Setup vectera
  Barrett.GetActorRef().Moveto(MQ104B_LinSandbox_CenterMarker)
  Lin.GetActorRef().moveto(MQ104B_LinSandbox_CenterMarker)
  Heller.GetActorRef().moveto(MQ104B_LinSandbox_CenterMarker)
  VecteraInteriorNPCEnableMarker.DisableNoWait()

  Self.RegisterForRemoteEvent(MineWallBreakable.GetReference(), "OnCellLoad")
  MQ101_BoringCollision.DisableNoWait()
  ArtifactDeposit.GetRef().DisableNoWait()
  ArtifactNotYetTakenEnableMarker.DisableNoWait()

  ;Reset Kreet
  LC003_InteriorBaseActorEnableMarker.DisableNoWait()
EndFunction

Event Quest.OnStageSet(Quest akSender, Int auiStageID, Int auiItemID)
  If(akSender == MQ101)
    If(auiStageID == 0)
      Utility.Wait(2)
      Game.FadeOutGame(True, True, 0.0, 0.1, True)          
      Utility.Wait(0.1)
      Game.ForceFirstPerson()
      StayBlack.Remove()
    EndIf

    If(UnityCount > 0 && RAS_DisableStarborn.GetValueInt() == 0)
      Game.GetPlayer().SetValue(PlayerUnityTimesEntered, UnityCount)
    EndIf

    Self.UnregisterForRemoteEvent(MQ101, "OnStageSet")
  ElseIf(akSender == MQ102 && auiStageID == 1150)
    RAS_MQ104B.SetStage(10)
    Self.UnregisterForRemoteEvent(MQ102, "OnStageSet")
  ElseIf(akSender == MQ104B)
    If(auiStageID == 390)
      MQ104B.SetObjectiveDisplayed(115, False, True)
    ElseIf(auiStageID == 2000)
      RAS_MQ104B.SetStage(0)
      Self.UnregisterForRemoteEvent(MQ104B, "OnStageSet")
    EndIf
  ElseIf(akSender == MQ401 )
    If(auiStageID == 110)                
      MQ401_VariantCurrent.SetValue(1) ;Changing at this point wont impact universe output but will prevent lodge scene

      ;Register hooks
      HookMQ()

      ;Setting up mq101 clone and make sure we stop listening to unequip events on alias
      RAS_MQ101.SetStage(25)
      RAS_MQ101.SetActive()

      ;Remove the frontier as it will be given later after Vectera quest
      Game.RemovePlayerOwnedShip(Frontier_ModularREF as SpaceshipReference)
    ElseIf(auiStageID == 300)
      RAS_MQ101.CompleteAllObjectives()
      RAS_MQ101.SetStage(2100)
    EndIf
  ElseIf(akSender == MQ305 && auiStageID == 100)
    Game.GetPlayer().SetValue(PlayerUnityTimesEntered, UnityCount)
  EndIf
EndEvent

Event ObjectReference.OnCellLoad(ObjectReference akSender)
  If(akSender == NewAtlantisToLodgeDoorREF)
    (Game.GetFormFromFile(0x110644, "Starfield.esm") as ObjectReference).Disable() ;Disable warning creating MQ101 trigger
    Self.UnregisterForRemoteEvent(NewAtlantisToLodgeDoorREF, "OnCellLoad")
  ElseIf(akSender == MineWallBreakable.GetReference())
    Utility.Wait(1) ;Wait for drill anim to end
    MineWallBreakable.GetReference().PlayAnimation("Stage2")
    MineBoringMachine.GetRef().PlayAnimation("Stage2NoTransition")
  EndIf
EndEvent

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

Event RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript.SelectionChanged(RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript akSender, var[] akArgs)
  HandleConfigurationChanged(akSender as ObjectReference)
EndEvent

Event RAS:NewGameConfiguration:DynamicTerminals:NarrativeAdjustments:NarrativeAdjustmentsActivatorScript.SelectionChanged(RAS:NewGameConfiguration:DynamicTerminals:NarrativeAdjustments:NarrativeAdjustmentsActivatorScript akSender, var[] akArgs)
  HandleConfigurationChanged(akSender as ObjectReference)
EndEvent

Event RAS:NewGameConfiguration:ShipVendorScript.ShipChanged(RAS:NewGameConfiguration:ShipVendorScript akSender, var[] akArgs)
  HandleConfigurationChanged(akSender as ObjectReference)
EndEvent

Function HandleConfigurationChanged(ObjectReference akConfigurator)
  var[] eventParams = new var[1]
  eventParams[0] = akConfigurator
  Self.SendCustomEvent("ConfigurationChanged", eventParams)
EndFunction