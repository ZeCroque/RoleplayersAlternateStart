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

Event OnQuestInit()
    If MQ101.GetStageDone(105) == True || Game.GetPlayer().GetValue(PlayerUnityTimesEntered) > 0
      (Self as Quest).Stop() 
    Else
        Game.GetPlayer().WaitFor3dLoad() ; #DEBUG_LINE_NO:171
        VascoREF.Disable(False)
        Self.RegisterForMenuOpenCloseEvent("ChargenMenu") ; #DEBUG_LINE_NO:342
        Game.ShowRaceMenu(None, 0, None, None, None) 
        Self.RegisterForRemoteEvent(MQ102, "OnStageSet")
    EndIf
EndEvent

Event OnMenuOpenCloseEvent(String asMenuName, Bool abOpening)
  If asMenuName == "ChargenMenu" && abOpening == False ; #DEBUG_LINE_NO:381
    Self.UnregisterForMenuOpenCloseEvent("ChargenMenu") ; #DEBUG_LINE_NO:382

    Game.SetInChargen(False, False, False) ; #DEBUG_LINE_NO:395
    Game.SetCharGenHUDMode(0) ; #DEBUG_LINE_NO:396
    Keyword pAnimArchetypePlayer = Game.GetFormFromFile(439560, "Starfield.esm") as Keyword ; #DEBUG_LINE_NO:397
    Game.GetPlayer().ChangeAnimArchetype(pAnimArchetypePlayer)

    Actor Vasco = VascoREF as Actor
    if(Vasco)
        MQ101VascoQuestFollower.SetValueInt(0)
        (SQ_Crew as sq_crewscript).SetRoleInactive(Vasco, False, False, True)
        (SQ_Followers as sq_followersscript).SetRoleInactive(Vasco, False, False, True)
        Vasco.RemoveKeyword(SQ_ActorRoles_SuppressMessages)
        Vasco.SetGhost(False)
        Vasco.MoveTo(LodgeStartMarker, -3.0, 3.0, 0.0, True, False)
        Vasco.Enable(False)
        CREW_EliteCrew_Vasco.SetStage(1)
        Vasco.EvaluatePackage(False)
    endif

    MQ101.SetObjectiveDisplayed(170, False, True) 
    MQ101.CompleteQuest()
    MQ101.Stop() ; #DEBUG_LINE_NO:642

    Self.RegisterForRemoteEvent(MQ104B, "OnStageSet")
    MQ104B.Start() ; #DEBUG_LINE_NO:657
    MQ104B.Stop()

    MQ102.SetStage(10)
    EndIf
EndEvent

Event Quest.OnStageSet(Quest akSender, Int auiStageID, Int auiItemID)
  If(akSender == MQ104B && auiStageID == 2000)
    RAS_MQ104B.SetStage(5)
    Self.UnregisterForRemoteEvent(MQ104B, "OnStageSet")
  ElseIf(akSender == MQ102 && auiStageID == 1150)
    RAS_MQ104B.SetStage(10)
    Self.UnregisterForRemoteEvent(MQ102, "OnStageSet")
  EndIf
EndEvent