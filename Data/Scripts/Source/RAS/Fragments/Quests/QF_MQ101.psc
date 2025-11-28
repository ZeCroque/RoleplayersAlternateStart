;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname RAS:Fragments:Quests:QF_MQ101 Extends Quest Hidden Const

;BEGIN FRAGMENT Fragment_Stage_0005_Item_00
Function Fragment_Stage_0005_Item_00()
;BEGIN AUTOCAST TYPE RAS:MQ101:MQ101Script
Quest __temp = self as Quest
RAS:MQ101:MQ101Script kmyQuest = __temp as RAS:MQ101:MQ101Script
;END AUTOCAST
;BEGIN CODE
Game.GetPlayer().AddItem(kmyQuest.ConstellationInvite.GetReference())
SetObjectiveDisplayed(5)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0010_Item_00
Function Fragment_Stage_0010_Item_00()
;BEGIN AUTOCAST TYPE RAS:MQ101:MQ101Script
Quest __temp = self as Quest
RAS:MQ101:MQ101Script kmyQuest = __temp as RAS:MQ101:MQ101Script
;END AUTOCAST
;BEGIN CODE
kmyQuest.ConstellationInvite.Clear()
kmyQuest.Vasco.GetReference().MoveTo(kmyQuest.MQ204_NA_HunterMarker)

SetObjectiveCompleted(5)
SetObjectiveDisplayed(10)

RAS_MQ104B.SetStage(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0015_Item_00
Function Fragment_Stage_0015_Item_00()
;BEGIN AUTOCAST TYPE RAS:MQ101:MQ101Script
Quest __temp = self as Quest
RAS:MQ101:MQ101Script kmyQuest = __temp as RAS:MQ101:MQ101Script
;END AUTOCAST
;BEGIN CODE
kmyQuest.ConstellationInvite.Clear()
kmyQuest.Vasco.GetReference().MoveTo(kmyQuest.MQ204_NA_HunterMarker)

SetObjectiveDisplayed(10)

RAS_MQ104B.SetStage(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0020_Item_00
Function Fragment_Stage_0020_Item_00()
;BEGIN CODE
SetObjectiveCompleted(10)
SetObjectiveDisplayed(20)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0025_Item_00
Function Fragment_Stage_0025_Item_00()
;BEGIN CODE
SetObjectiveDisplayed(10)

RAS_MQ104B.SetStage(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_1510_Item_00
Function Fragment_Stage_1510_Item_00()
;BEGIN CODE
RAS_MQ101_034b_InsideLodgeScene.Start()

SetObjectiveCompleted(20)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_1600_Item_00
Function Fragment_Stage_1600_Item_00()
;BEGIN AUTOCAST TYPE RAS:MQ101:MQ101Script
Quest __temp = self as Quest
RAS:MQ101:MQ101Script kmyQuest = __temp as RAS:MQ101:MQ101Script
;END AUTOCAST
;BEGIN CODE
kmyquest.MQ101DisablePlayerControls()

RAS_MQ101_034b_InsideLodgeScene.Stop()
RAS_MQ101_034c_Stage1600Scene.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_1610_Item_00
Function Fragment_Stage_1610_Item_00()
;BEGIN CODE
SetObjectiveCompleted(185)
SetObjectiveDisplayed(187)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_1620_Item_00
Function Fragment_Stage_1620_Item_00()
;BEGIN CODE
ObjectReference TableREF = LodgeTableActivator.GetRef()
SarahMorgan.GetActorRef().EvaluatePackage()

;allow player to activate the table trigger
TableREF.Enable()

SetObjectiveCompleted(185)
SetObjectiveCompleted(187)
SetObjectiveDisplayed(190)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_1630_Item_00
Function Fragment_Stage_1630_Item_00()
;BEGIN AUTOCAST TYPE RAS:MQ101:MQ101Script
Quest __temp = self as Quest
RAS:MQ101:MQ101Script kmyQuest = __temp as RAS:MQ101:MQ101Script
;END AUTOCAST
;BEGIN CODE
ObjectReference TableREF = LodgeTableActivator.GetRef()
ObjectReference ArmillaryREF = Armillary.GetRef()

TableREF.Disable() ;player cannot activate table again
Game.GetPlayer().RemoveItem(kmyQuest.Artifact01REF)

ArmillaryREF.PlayAnimation("Equip")

RAS_MQ101_039c_ArtifactsTogether03.Start()

SetObjectiveCompleted(190)
SetObjectiveDisplayed(195)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_1635_Item_00
Function Fragment_Stage_1635_Item_00()
;BEGIN CODE
LodgeArtifact01.GetRef().DisableNoWait()
NoelArtifact01.GetRef().DisableNoWait()
NoelArtifact02.GetRef().DisableNoWait()

ObjectReference ArmillaryREF = Armillary.GetRef()
(ArmillaryREF as ArmillaryScript).MQ101ArmillaryComesTogether()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_1660_Item_00
Function Fragment_Stage_1660_Item_00()
;BEGIN CODE
SetStage(1635)

SetObjectiveCompleted(195)
SetObjectiveDisplayed(200)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_1800_Item_00
Function Fragment_Stage_1800_Item_00()
;BEGIN CODE
Game.StopDialogueCamera()
CompleteAllObjectives()

MQ102.SetStageNoWait(10)
FFLodge01.SetStageNoWait(10)

Actor PlayerREF = Game.GetPlayer()
PlayerREF.AddToFaction(ConstellationFaction)
PlayerREF.AddItem(LodgeKey)

Actor VascoREF = Vasco.GetReference() as Actor
VascoREF.SetFactionRank(PotentialCrewFaction, 1)
VascoREF.AddPerk(Crew_AneutronicFusion)
VascoREF.AddPerk(Crew_Ship_Shields)
VascoREF.AddPerk(Crew_Ship_Shields)
VascoREF.AddPerk(Crew_Ship_Weapons_EM)
VascoEliteCrewQuest.SetStageNoWait(1)

;UnGhost Actors
SarahMorgan.GetActorRef().SetGhost(False)
WalterStroud.GetActorRef().SetGhost(False)
Vasco.GetActorRef().SetGhost(False)
Matteo.GetActorRef().SetGhost(False)
Noel.GetActorRef().SetGhost(False)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_1810_Item_00
Function Fragment_Stage_1810_Item_00()
;BEGIN CODE
Stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Scene Property RAS_MQ101_034b_InsideLodgeScene Auto Const Mandatory

Scene Property RAS_MQ101_034c_Stage1600Scene Auto Const Mandatory

ReferenceAlias Property LodgeTableActivator Auto Const

ReferenceAlias Property SarahMorgan Auto Const

Scene Property RAS_MQ101_039c_ArtifactsTogether03 Auto Const Mandatory

ReferenceAlias Property Armillary Auto Const

ReferenceAlias Property LodgeArtifact01 Auto Const

ReferenceAlias Property NoelArtifact01 Auto Const

ReferenceAlias Property NoelArtifact02 Auto Const

Quest Property MQ102 Auto Const Mandatory

ReferenceAlias Property Vasco Auto Const

Quest Property FFLodge01 Auto Const Mandatory

Perk Property Crew_AneutronicFusion Auto Const Mandatory

Perk Property CREW_Ship_Shields Auto Const Mandatory

Perk Property CREW_Ship_Weapons_EM Auto Const Mandatory

Faction Property ConstellationFaction Auto Const Mandatory

Faction Property PotentialCrewFaction Auto Const Mandatory

Key Property LodgeKey Auto Const Mandatory

Quest Property RAS_MQ104B Auto Const Mandatory

Quest Property VascoEliteCrewQuest Mandatory Const Auto

ReferenceAlias Property WalterStroud Mandatory Const Auto

ReferenceAlias Property Matteo Mandatory Const Auto

ReferenceAlias Property Noel Mandatory Const Auto
