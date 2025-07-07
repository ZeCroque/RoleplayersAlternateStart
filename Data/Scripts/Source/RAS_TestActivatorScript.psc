Scriptname RAS_TestActivatorScript extends ObjectReference

ObjectReference Property RAS_NoneShipReference Mandatory Const Auto
ObjectReference Property Frontier_ModularREF Mandatory Const Auto
Quest Property RAS_ArtifactGenerationQuest Mandatory Const Auto
Quest Property StarbornTempleQuest Mandatory Const Auto
Quest Property MQ101 Mandatory Const Auto
ActorValue Property SpaceshipRegistration Mandatory Const Auto
Quest Property SQ_Crew Auto Const mandatory
Quest Property SQ_Followers Auto Const mandatory
GlobalVariable Property MQ101VascoQuestFollower Auto Const mandatory
Keyword Property SQ_ActorRoles_SuppressMessages Auto Const mandatory
ObjectReference Property LodgeStartMarker Auto Const mandatory
Quest Property CREW_EliteCrew_Vasco Auto Const mandatory
ObjectReference Property VascoREF Auto Const Mandatory

InputEnableLayer FastTravelInputLayer

Function RASDisableFastTravel()
    FastTravelInputLayer = InputEnableLayer.Create()
    FastTravelInputLayer.EnableFastTravel(False)
EndFunction

Function RASEnableFastTravel()
    If (FastTravelInputLayer != None)
		FastTravelInputLayer.EnableFastTravel(True)
		FastTravelInputLayer.Delete()
		FastTravelInputLayer = None
    EndIf
EndFunction

Event OnActivate(ObjectReference akActionRef)
	; Game.AddPlayerOwnedShip(RAS_NoneShipReference as SpaceshipReference)
	; Game.TrySetPlayerHomeSpaceShip(RAS_NoneShipReference)
	; RAS_NoneShipReference.SetValue(SpaceshipRegistration, 1)
 	; RAS_NoneShipReference.RemoveAllItems()
	; Game.RemovePlayerOwnedShip(Frontier_ModularREF as SpaceshipReference)
	; RASDisableFastTravel()
	; RAS_ArtifactGenerationQuest.SetStage(10)

	; RAS_ArtifactGenerationQuestScript questScript = RAS_ArtifactGenerationQuest as RAS_ArtifactGenerationQuestScript
	; ObjectReference ArtifactActivator01REF = (StarbornTempleQuest as StarbornTempleQuestScript).PlaceEmbeddedArtifact(0, questScript.Artifact.GetRef())
	; questScript.Artifact.ForceRefTo(ArtifactActivator01REF)
	; ArtifactActivator01REF.EnableNoWait()

	; questScript.ArtifactOpenCaveMarker.GetRef().EnableNoWait()
	; questScript.ArtifactClosedCaveMarker.GetRef().DisableNoWait()

	; Game.GetPlayer().MoveTo(questScript.Artifact.GetReference())

	MQ101.SetObjectiveCompleted(170)  
	MQ101.SetObjectiveDisplayed(170, False, True)  
EndEvent
