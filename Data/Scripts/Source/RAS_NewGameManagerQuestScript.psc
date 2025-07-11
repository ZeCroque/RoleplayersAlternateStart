Scriptname RAS_NewGameManagerQuestScript extends Quest

Quest Property MQ101 Mandatory Const Auto
Quest Property MQ102 Mandatory Const Auto
Quest Property MQ104B Mandatory Const Auto
Quest Property RAS_MQ104B Mandatory Const Auto
ActorValue Property PlayerUnityTimesEntered Auto Const mandatory
Quest Property SQ_Crew Auto Const mandatory
Quest Property SQ_Followers Auto Const mandatory
GlobalVariable Property MQ101VascoQuestFollower Auto Const mandatory
Keyword Property SQ_ActorRoles_SuppressMessages Auto Const mandatory
ObjectReference Property LodgeStartMarker Auto Const mandatory
Quest Property CREW_EliteCrew_Vasco Auto Const mandatory
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

Event OnQuestInit()
    If MQ101.GetStageDone(105) == True || Game.GetPlayer().GetValue(PlayerUnityTimesEntered) > 0
      (Self as Quest).Stop() 
    Else
        Game.GetPlayer().SetValue(PlayerXPBonusMult, 0) ;Prevent level up
        Game.GetPlayer().WaitFor3dLoad()
        Self.RegisterForMenuOpenCloseEvent("ChargenMenu")
        Game.ShowRaceMenu(None, 0, None, None, None) 
    EndIf
EndEvent

Event OnMenuOpenCloseEvent(String asMenuName, Bool abOpening)
  If asMenuName == "ChargenMenu" && abOpening == False
    Self.UnregisterForMenuOpenCloseEvent("ChargenMenu")

    Game.SetInChargen(False, False, False)
    Game.SetCharGenHUDMode(0)
    Keyword pAnimArchetypePlayer = Game.GetFormFromFile(439560, "Starfield.esm") as Keyword
    Game.GetPlayer().ChangeAnimArchetype(pAnimArchetypePlayer)

    ;Clear vasco that is set as temp follower by debug stage
    Actor Vasco = VascoREF as Actor
    (SQ_Crew as sq_crewscript).SetRoleInactive(Vasco, False, False, True)
    (SQ_Followers as sq_followersscript).SetRoleInactive(Vasco, False, False, True)
    Vasco.RemoveKeyword(SQ_ActorRoles_SuppressMessages)
    Vasco.MoveTo(LodgeStartMarker, -3.0, 3.0, 0.0, True, False)

    MQ101.SetObjectiveDisplayed(170, False, True) ;This will ensure we don't see the quest in the log
    ;We need to stop the quest to prevent scenes to occur, but we need to have this stage done for constellation dialogs to work
    ;So we set the final stage but we will undo all the changes once the final stage is set (we'll set them back later)
    Self.RegisterForRemoteEvent(MQ101, "OnStageSet")
    Self.RegisterForRemoteEvent(MQ102, "OnStageSet")
    Self.RegisterForRemoteEvent(FFLodge01, "OnStageSet")
    MQ101.SetStage(1800) 
    MQ101.Stop()

    ;Add required triggers from stages we skipped
    City_NA_Aquilus01.Start()

    ;Prevent the real MQ104B to happen and wait for closing stage to undo the changes in RAS_MQ104B stage 5 fragment
    Self.RegisterForRemoteEvent(MQ104B, "OnStageSet")
    MQ104B.Start()
    MQ104B.Stop()

    ;Locks the lodge until we start the custom quest
    NewAtlantisToLodgeDoorREF.SetLockLevel(254)
    NewAtlantisToLodgeDoorREF.Lock()
    EndIf
EndEvent

Event Quest.OnStageSet(Quest akSender, Int auiStageID, Int auiItemID)
  Utility.Wait(1.0) ;meant to lose the race with the fragment that runs in parallel, unfortunately bugprone
  If(akSender == MQ101 && auiStageID == 9000)
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
  ElseIf(akSender == MQ104B && auiStageID == 2000)
    RAS_MQ104B.SetStage(5)
    Self.UnregisterForRemoteEvent(MQ104B, "OnStageSet")
  EndIf
EndEvent