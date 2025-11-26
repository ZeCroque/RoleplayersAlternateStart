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
ReferenceAlias Property ArtifactDeposit Mandatory Const Auto
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
ObjectReference Property MQPlayerStarbornShipREF Mandatory Const Auto
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
Keyword Property RAS_StartMQ101EventKeyword Mandatory Const Auto
Quest Property TraitKidStuff Mandatory Const Auto
Quest Property TraitStarterHome Mandatory Const Auto
Perk Property PERK_StarterHome Mandatory Const Auto

InputEnableLayer Property InputLayer Auto Hidden
ObjectReference Property FastTravelTarget Auto Hidden
Bool Property StarbornStart Auto Conditional
Bool Property StarbornVanillaStart Auto Conditional

CustomEvent ConfigurationChanged

Function InitCustomStart()
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

    Self.RegisterForMenuOpenCloseEvent("ChargenMenu")

    Game.GetPlayer().SetValue(RAS_AlternateStart, 1)
EndFunction

Event OnStageSet(int auiStageID, int auiItemID)
  If(auiStageID == 5)
    SetObjectiveCompleted(10)
    CompleteQuest()      
    Stop()

    Self.RegisterForRemoteEvent(MQ101, "OnStageSet")
    RAS_StartMQ101EventKeyword.SendStoryEventAndWait()

    InputLayer.Delete()
  EndIf
EndEvent
;TODO vanilla+ option with MQ101

Event OnMenuOpenCloseEvent(String asMenuName, Bool abOpening)
  If (asMenuName == "ChargenMenu" && abOpening == False)
    Self.UnregisterForMenuOpenCloseEvent("ChargenMenu")

    ;Locks the lodge until we start the custom quest
    NewAtlantisToLodgeDoorREF.SetLockLevel(254)
    NewAtlantisToLodgeDoorREF.Lock()

    SetStage(10)
    CustomStartSetup()
    ;TODO remove constellation gear
    Game.FastTravel(RAS_ChooseStartCellMarkerREF)
    StayBlack.Remove()
    InputLayer.Delete()
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
EndFunction

Function HookMQ()
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

  (NewAtlantisToLodgeDoorREF as FrontDoorToLodgeScript).LodgeFrontDoorOpen = True
  ;Register to remove unwanted vasco trigger  
  Self.RegisterForRemoteEvent(NewAtlantisToLodgeDoorREF, "OnCellLoad")
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

Event Quest.OnStageSet(Quest akSender, Int auiStageID, Int auiItemID)
  ; MQ101SaveOff.SetValue(0) ;Prevent saving in NG+
  ; Utility.Wait(1.0) ;meant to lose the race with the fragment that runs in parallel, unfortunately bugprone
  If(akSender == MQ101 && auiStageID == 0)
      Utility.Wait(2)
      Game.FadeOutGame(True, True, 0.0, 0.1, True)          
      Utility.Wait(0.1)
      StayBlack.Remove()
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
  ; ElseIf(akSender == MQ401 )
  ;   If(auiStageID == 110)    
  ;     SetObjectiveDisplayed(10, False, True)
  ;     If(MQ401_VariantCurrent.GetValue() == 0)
  ;       MQ401_VariantCurrent.SetValue(1) ;Changing at this point wont impact universe output but will prevent lodge scene
  ;       StarbornVanillaStart = True

  ;       ;Put starborn items aside to prevent them from being erased with MQ101 quest rewards by hooks
  ;       Game.GetPlayer().RemoveAllItems(RAS_StartingStuffContainer)
        
  ;       ;Register hooks
  ;       HookMQ()

  ;       ;Setting up mq101 clone and make sure we stop listening to unequip events on alias
  ;       RAS_MQ101.SetStage(25)
  ;       RAS_MQ101.SetActive()
  ;     Else
  ;       Game.FastTravel(RAS_TmpCellMarkerREF)
  ;     EndIf
  ;   ElseIf(auiStageID == 300)
  ;     RAS_MQ101.CompleteAllObjectives()
  ;     RAS_MQ101.SetStage(2100)
  ;     MQ401_SkipMQ.SetValueInt(1)
  ;     MQ102.Stop()
  ;     MQ402.SetStage(10)

  ;     COM_Companion_SamCoe_CoraCoe_Handler.Start()
  ;     If(MQ401.GetStageDone(300))
  ;       FFLodge01.Stop()
  ;     Else
  ;       FFLodge01.SetObjectiveDisplayed(10, true, true)
  ;     EndIf

  ;     Actor PlayerREF = Game.GetPlayer()
  ;     PlayerREF.AddToFaction(ConstellationFaction)
  ;     PlayerREF.AddItem(LodgeKey)
  ;     PlayerREF.addtoFaction(EyeBoardingFaction)

  ;     Actor Vasco = VascoREF as Actor
  ;     Vasco.SetFactionRank(PotentialCrewFaction, 1)
  ;     Vasco.AddPerk(Crew_Ship_AneutronicFusion)
  ;     Vasco.AddPerk(Crew_Ship_Shields)
  ;     Vasco.AddPerk(Crew_Ship_Shields)
  ;     Vasco.AddPerk(Crew_Ship_Weapons_EM)

  ;     Game.AddPlayerOwnedShip(Frontier_ModularREF as SpaceshipReference)
  ;   EndIf
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

Event Location.OnLocationLoaded(Location akSender)
  StarbornGuardianSeat.GetReference().Enable()
  Game.GetPlayer().SnapIntoInteraction(StarbornGuardianSeat.GetReference())

  Game.SetInChargen(False, False, False) 
  Game.RequestSave()

  If(StarbornVanillaStart == False)
    Stop()
  EndIf

  Self.UnregisterForRemoteEvent(MQPlayerStarbornShipREF.GetCurrentLocation(), "OnLocationLoaded")
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