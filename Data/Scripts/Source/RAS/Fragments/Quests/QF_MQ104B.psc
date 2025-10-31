;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname RAS:Fragments:Quests:QF_MQ104B Extends Quest Hidden Const

;BEGIN FRAGMENT Fragment_Stage_0000_Item_00
Function Fragment_Stage_0000_Item_00()
;BEGIN CODE
LC001VecteraLiftDoor.SetLockLevel(254)
LC001VecteraLiftDoor.Lock()

;undo crew quests changes
Actor LinRef = Alias_Lin.GetActorRef()
LinRef.RemoveFromFaction(PotentialCrewFaction)
LinRef.RemovePerk(Crew_Demolitions)
LinRef.RemovePerk(Crew_Outpost_Management)
LinRef.RemovePerk(Crew_Outpost_Management)
LinRef.RemovePerk(Crew_Outpost_Management)

Actor HellerREF = Alias_Heller.GetActorRef()
HellerRef.RemoveFromFaction(PotentialCrewFaction)
HellerRef.RemovePerk(Crew_Geology)
HellerRef.RemovePerk(Crew_Outpost_Engineering)
HellerRef.RemovePerk(Crew_Outpost_Engineering)
HellerRef.RemovePerk(Crew_Outpost_Engineering)

Alias_Barrett.GetActorRef().moveto(MQ104B_BarrettMovetoMarker)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0001_Item_00
Function Fragment_Stage_0001_Item_00()
;BEGIN CODE
Frontier_ModularREF.MoveTo(VecteraShipLandingMarker)
Frontier_ModularREF.SetLinkedRef(VecteraShipLandingMarker, CurrentInteractionLinkedRefKeyword)
Frontier_ModularREF.Enable()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0005_Item_00
Function Fragment_Stage_0005_Item_00()
;BEGIN CODE
LC001VecteraLiftDoor.Unlock()

;allow landing at Vectera again
Alias_VecteraMapMarker.GetRef().Enable()

;set up the state change on Vectera
VecteraExteriorNPCEnableMarker001.Disable()
VecteraInteriorNPCEnableMarker.Disable()

Actor HellerREF = Alias_Heller.GetActorRef()
HellerREF.moveto(Alias_HellerWoundedMArker.GetRef())
HellerREF.SetGhost()
HellerREF.AddtoFaction(CaptiveFaction)

;make sure door to Barret dungeon is open
Alias_BarrettDungeonDoor.GetRef().Lock(False)

Alias_CommsComputer.GetRef().Enable()
Alias_CommsComputer.GetRef().BlockActivation(True, True)

Alias_Lin.GetActorRef().moveto(MQ104BLinTravelMarker)

;stopping MQ104B in RAS_NewGameManagerQuestScript trigggers unwanted changes so we're undoing them
;make sure Matsura and his bodyguards aren't hostile
Actor MatsuraREF = Alias_Matsura.GetActorRef()
MatsuraREF.RemoveFromFaction(PlayerEnemyFaction)
Alias_MatsuraBodyguards.RemoveFromFaction(PlayerEnemyFaction)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0010_Item_00
Function Fragment_Stage_0010_Item_00()
;BEGIN CODE
SetObjectiveDisplayed(10)

;make sure we set up the Vectera state change
SetStage(5)

;start Heller and Lin's base dialogue quest for dialogue needed when this quest isn't running
MQ104B_LinHeller_BaseDialogue.Start()

MQ104B_BarrettCell_EnableMaker.Disable()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0015_Item_00
Function Fragment_Stage_0015_Item_00()
;BEGIN CODE
SetObjectiveCompleted(10)
SetObjectiveDisplayed(20)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0020_Item_00
Function Fragment_Stage_0020_Item_00()
;BEGIN CODE
SetObjectiveCompleted(10)
SetObjectiveDisplayed(20)

RAS_MQ104B_001_LinScene.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0030_Item_00
Function Fragment_Stage_0030_Item_00()
;BEGIN CODE
SetObjectiveCompleted(20)
SetObjectiveDisplayed(30)
SetObjectiveDisplayedAtTop(30)

;enable trigger volume to repair computer
Alias_BrokenComputerTrigger.GetRef().Enable()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0040_Item_00
Function Fragment_Stage_0040_Item_00()
;BEGIN CODE
Actor PlayerREF = Game.GetPlayer()

PlayerREF.RemoveItem(Power_Cell, 3)

SetObjectiveCompleted(30)
SetObjectiveCompleted(35)
SetObjectiveDisplayed(40)

ObjectReference CommsComputerREF = Alias_CommsComputer.GetRef()

Alias_BrokenComputerTrigger.GetRef().Disable()
CommsComputerREF.BlockActivation(False, False)
CommsComputerREF.PlayAnimation("Play01")

;play sound
OBJ_MQ104B_Computer_Repair.Play(Game.GetPlayer())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0045_Item_00
Function Fragment_Stage_0045_Item_00()
;BEGIN CODE
SetObjectiveDisplayed(35)

Alias_MedBenchTrigger.GetRef().Enable()
Alias_BotTrigger.GetRef().Enable()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0050_Item_00
Function Fragment_Stage_0050_Item_00()
;BEGIN CODE
SetObjectiveCompleted(30)
SetObjectiveCompleted(35)
SetObjectiveDisplayed(40)

ObjectReference CommsComputerREF = Alias_CommsComputer.GetRef()

Alias_BrokenComputerTrigger.GetRef().Disable()
CommsComputerREF.BlockActivation(False, False)
CommsComputerREF.PlayAnimation("Play01")

;play sound
OBJ_MQ104B_Computer_Repair.Play(Game.GetPlayer())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0055_Item_00
Function Fragment_Stage_0055_Item_00()
;BEGIN CODE
SetObjectiveCompleted(30)
SetObjectiveCompleted(35)
SetObjectiveCompleted(40)
SetObjectiveDisplayed(50)

Alias_BrokenComputerTrigger.GetRef().Disable()

;give player the slate directly
Game.GetPlayer().addaliaseditem(MQ104BHellerBarrettSlate, Alias_FirstBarrettSlateQuestObject)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0060_Item_00
Function Fragment_Stage_0060_Item_00()
;BEGIN CODE
Game.GetPlayer().AddItem(Power_Cell, 1)

If GetStageDone(80) && GetStageDone(70)
  SetStage(90)
EndIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0070_Item_00
Function Fragment_Stage_0070_Item_00()
;BEGIN CODE
MQ104BVectera_MedBenchMSG02.Show()
Game.GetPlayer().AddItem(Power_Cell, 1)

If GetStageDone(60) && GetStageDone(80)
  SetStage(90)
EndIf

Alias_MedBenchTrigger.GetRef().Disable()

;play sound
OBJ_MQ104B_Power_Circuit.Play(Game.GetPlayer())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0080_Item_00
Function Fragment_Stage_0080_Item_00()
;BEGIN CODE
MQ104BVectera_RobotMSG02.Show()
Game.GetPlayer().AddItem(Power_Cell, 1)

If GetStageDone(60) && GetStageDone(70)
  SetStage(90)
EndIf

Alias_BotTrigger.GetRef().Disable()

;play sound
OBJ_MQ104B_Power_Circuit.Play(Game.GetPlayer())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0090_Item_00
Function Fragment_Stage_0090_Item_00()
;BEGIN CODE
SetObjectiveCompleted(35)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0095_Item_00
Function Fragment_Stage_0095_Item_00()
;BEGIN CODE
Actor PlayerREF = Game.GetPlayer()

SetObjectiveCompleted(30)
SetObjectiveCompleted(35)
SetObjectiveDisplayed(40)

ObjectReference CommsComputerREF = Alias_CommsComputer.GetRef()

Alias_BrokenComputerTrigger.GetRef().Disable()
CommsComputerREF.BlockActivation(False, False)
CommsComputerREF.PlayAnimation("Play01")

;play sound
OBJ_MQ104B_Computer_Repair.Play(Game.GetPlayer())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0100_Item_00
Function Fragment_Stage_0100_Item_00()
;BEGIN CODE
SetStage(30)

SetObjectiveCompleted(30)
SetObjectiveCompleted(40)
SetObjectiveCompleted(50)
SetObjectiveDisplayed(60)

Actor PlayerREF = Game.GetPlayer()
If PlayerREF.GetItemCount(MQ104BHellerBarrettSlate) == 0
  PlayerREF.AddItem(MQ104BHellerBarrettSlate)
EndIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0110_Item_00
Function Fragment_Stage_0110_Item_00()
;BEGIN CODE
SetObjectiveCompleted(60)
SetObjectiveDisplayed(65)
SetObjectiveDisplayed(67)
SetObjectiveDisplayedAtTop(65)

;changes from LinEliteCrewQuest
Actor LinRef = Alias_Lin.GetActorRef()
LinRef.SetFactionRank(PotentialCrewFaction, 1)
LinRef.AddPerk(Crew_Demolitions)
LinRef.AddPerk(Crew_Outpost_Management)
LinRef.AddPerk(Crew_Outpost_Management)
LinRef.AddPerk(Crew_Outpost_Management)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0112_Item_00
Function Fragment_Stage_0112_Item_00()
;BEGIN CODE
SetObjectiveCompleted(67)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0115_Item_00
Function Fragment_Stage_0115_Item_00()
;BEGIN CODE
SetObjectiveCompleted(65)
SetObjectiveDisplayed(70)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0120_Item_00
Function Fragment_Stage_0120_Item_00()
;BEGIN CODE
SetObjectiveCompleted(70)
SetObjectiveDisplayed(80)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0125_Item_00
Function Fragment_Stage_0125_Item_00()
;BEGIN CODE
SetObjectiveCompleted(92)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0130_Item_00
Function Fragment_Stage_0130_Item_00()
;BEGIN CODE
Actor HellerREF = Alias_Heller.GetActorRef()

Game.GetPlayer().addaliaseditem(MQ104BPirateBarrettSlate, Alias_SecondBarrettSlateQuestObject)

;changes from HellerEliteCrewQuest
HellerRef.SetFactionRank(PotentialCrewFaction, 1)
HellerRef.AddPerk(Crew_Geology)
HellerRef.AddPerk(Crew_Outpost_Engineering)
HellerRef.AddPerk(Crew_Outpost_Engineering)
HellerRef.AddPerk(Crew_Outpost_Engineering)
HellerREF.EvaluatePackage()
HellerREF.SetGhost(False)
HellerREF.RemoveFromFaction(CaptiveFaction)

;make sure quest advances if we skipped ahead
SetStage(100)
SetStage(110)
SetStage(115)
SetStage(120)

SetObjectiveCompleted(10)
SetObjectiveCompleted(20)
SetObjectiveCompleted(30)
SetObjectiveCompleted(35)
SetObjectiveCompleted(50)
SetObjectiveCompleted(60)
SetObjectiveCompleted(80)
SetObjectiveDisplayed(85)
SetObjectiveDisplayed(92)
SetObjectiveDisplayedAtTop(85)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0131_Item_00
Function Fragment_Stage_0131_Item_00()
;BEGIN CODE
SetObjectiveCompleted(85)
SetObjectiveDisplayed(90)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0132_Item_00
Function Fragment_Stage_0132_Item_00()
;BEGIN CODE
SetObjectiveCompleted(85)
SetObjectiveCompleted(90)
SetObjectiveDisplayed(100)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0140_Item_00
Function Fragment_Stage_0140_Item_00()
;BEGIN CODE
RAS_MQ104B_005_OutsideScene.start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0150_Item_00
Function Fragment_Stage_0150_Item_00()
;BEGIN CODE
RAS_MQ104B_005_OutsideScene.Stop()
RAS_MQ104B_006_BarrettScene.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0240_Item_00
Function Fragment_Stage_0240_Item_00()
;BEGIN CODE
Game.GetPlayer().removeitem(credits, NPCDemandMoney_Large.GetValueInt())

SetStage(300)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0250_Item_00
Function Fragment_Stage_0250_Item_00()
;BEGIN CODE
SetStage(300)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0260_Item_00
Function Fragment_Stage_0260_Item_00()
;BEGIN CODE
Actor MatsuraREF = Alias_Matsura.GetActorRef()
MatsuraREF.AddtoFaction(PlayerEnemyFaction)
Alias_MatsuraBodyguards.AddtoFaction(PlayerEnemyFaction)
MatsuraREF.StartCombat(Game.GetPlayer())

SetObjectiveDisplayed(105)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0270_Item_00
Function Fragment_Stage_0270_Item_00()
;BEGIN CODE
SetObjectiveCompleted(105)
SetStage(300)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0300_Item_00
Function Fragment_Stage_0300_Item_00()
;BEGIN CODE
SetObjectiveCompleted(100)
SetObjectiveDisplayed(110)

;if we did this non-violently, disable the exterior hostiles
If GetStageDone(260) == 0
  MQ104B_EnableExteriorPiratesMarker.Disable()
EndIf

Actor BarrettREF = Alias_Barrett.GetActorRef()
BarrettREF.EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0305_Item_00
Function Fragment_Stage_0305_Item_00()
;BEGIN CODE
Actor BarrettREF = Alias_Barrett.GetActorRef()

;Barrett is now a temp passenger
(SQ_PlayerShip as SQ_PlayerShipScript).AddPassenger(BarrettREF)
BarrettREF.moveto(Alias_PlayerShipPassengerMarker.GetRef())
BarrettREF.EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0310_Item_00
Function Fragment_Stage_0310_Item_00()
;BEGIN CODE
Actor BarrettREF = Alias_Barrett.GetActorRef()

;Barrett is no longer a passenger
(SQ_PlayerShip as SQ_PlayerShipScript).RemovePassenger(BarrettREF)
Passengers.RemoveRef(BarrettREF)
DisembarkingCrew.RemoveRef(BarrettREF)

BarrettREF.moveto(MQ104B_Lodge_MarkerBarrett01)

BarrettREF.evaluatepackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0390_Item_00
Function Fragment_Stage_0390_Item_00()
;BEGIN CODE
SetObjectiveCompleted(110)
SetObjectiveDisplayed(115)

Actor BarrettREF = Alias_Barrett.GetActorRef()

;Barrett is no longer a passenger
(SQ_PlayerShip as SQ_PlayerShipScript).RemovePassenger(BarrettREF)
Passengers.RemoveRef(BarrettREF)
DisembarkingCrew.RemoveRef(BarrettREF)

BarrettREF.moveto(MQ104B_Lodge_MarkerBarrett01)
BarrettREF.evaluatepackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0400_Item_00
Function Fragment_Stage_0400_Item_00()
;BEGIN CODE
RAS_MQ104B_014_LodgeScene.Start()

SetObjectiveCompleted(115)
SetObjectiveDisplayed(120)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0405_Item_00
Function Fragment_Stage_0405_Item_00()
;BEGIN CODE
SetObjectiveCompleted(120)
SetObjectiveDisplayed(130)

Alias_Barrett.GetActorRef().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0407_Item_00
Function Fragment_Stage_0407_Item_00()
;BEGIN CODE
Alias_Barrett.GetActorRef().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0410_Item_00
Function Fragment_Stage_0410_Item_00()
;BEGIN AUTOCAST TYPE defaulttutorialquestscript
Quest __temp = self as Quest
defaulttutorialquestscript kmyQuest = __temp as defaulttutorialquestscript
;END AUTOCAST
;BEGIN CODE
Actor BarrettREF = Alias_Barrett.GetActorRef()
(SQ_Companions as SQ_CompanionsScript).SetRoleAvailable(BarrettREF)

;only make Barrett active if there is no locked in companion
If COM_PQ_LockedInCompanion.GetValueInt() > -1
  kmyquest.ShowHelpMessage("CompanionBlocked")
Else 
  (SQ_Companions as SQ_CompanionsScript).SetRoleActive(BarrettREF)
  BarrettREF.EvaluatePackage()
EndIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0420_Item_00
Function Fragment_Stage_0420_Item_00()
;BEGIN CODE
Actor BarrettREF = Alias_Barrett.GetActorRef()
(SQ_Companions as SQ_CompanionsScript).SetRoleAvailable(BarrettREF)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_1000_Item_00
Function Fragment_Stage_1000_Item_00()
;BEGIN CODE
CompleteAllObjectives()

;check if MQ105 should start
If MQ103.GetStageDone(2000) && MQ104A.GetStageDone(1000)
  MQ105.SetStage(10)
EndIf

Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_2000_Item_00
Function Fragment_Stage_2000_Item_00()
;BEGIN CODE
;make sure Matsura is hostile
Actor MatsuraREF = Alias_Matsura.GetActorRef()
MatsuraREF.AddtoFaction(PlayerEnemyFaction)
Alias_MatsuraBodyguards.AddtoFaction(PlayerEnemyFaction)

;make sure Heller isn't ghosted
Alias_Heller.GetActorRef().SetGhost(false)

;run crew quests
LinEliteCrewQuest.SetStage(1)
HellerEliteCrewQuest.SetStage(1)

;trigger unwanted hero if applicable now it makes sense
If(Game.GetPlayer().HasPerk(TRAIT_UnwantedHero))
  TraitUnwantedHero.Reset()
  TraitUnwantedHero.Start()
  TraitUnwantedHero.SetStage(80)
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property Alias_Barrett Auto Const Mandatory

ReferenceAlias Property Alias_Heller Auto Const Mandatory

Quest Property MQ103 Auto Const Mandatory

Quest Property MQ104 Auto Const Mandatory

Quest Property MQ105 Auto Const Mandatory

ObjectReference Property VecteraExteriorNPCEnableMarker Auto Const Mandatory

ObjectReference Property VecteraInteriorNPCEnableMarker Auto Const Mandatory

ReferenceAlias Property Alias_Lin Auto Const Mandatory

ObjectReference Property MQ104B_BarrettMovetoMarker Auto Const Mandatory

Message Property MQ104BVectera_MedBenchMSG02 Auto Const Mandatory

ReferenceAlias Property Alias_MedBenchTrigger Auto Const Mandatory

ReferenceAlias Property Alias_BotTrigger Auto Const Mandatory

ReferenceAlias Property Alias_CommsComputer Auto Const Mandatory

Message Property MQ104BVectera_RobotMSG02 Auto Const Mandatory

Book Property MQ104BHellerBarrettSlate Auto Const Mandatory

Book Property MQ104BPirateBarrettSlate Auto Const Mandatory

Scene Property RAS_MQ104B_005_OutsideScene Auto Const Mandatory

ReferenceAlias Property Alias_Matsura Auto Const Mandatory

Faction Property PlayerEnemyFaction Auto Const Mandatory

Quest Property MQ104A Auto Const Mandatory

Quest Property MQ104B_LinHeller_BaseDialogue Auto Const Mandatory

MiscObject Property Credits Auto Const Mandatory

RefCollectionAlias Property Alias_MatsuraBodyguards Auto Const Mandatory

ReferenceAlias Property Alias_HellerWoundedMarker Auto Const Mandatory

ReferenceAlias Property Alias_BarrettDungeonDoor Auto Const Mandatory

ObjectReference Property MQ104B_EnableExteriorPiratesMarker Auto Const Mandatory

ReferenceAlias Property Alias_BrokenComputerTrigger Auto Const Mandatory

ReferenceAlias Property Alias_FirstBarrettSlateQuestObject Auto Const Mandatory

Scene Property RAS_MQ104B_001_LinScene Auto Const Mandatory

GlobalVariable Property NPCDemandMoney_Large Auto Const Mandatory

Scene Property RAS_MQ104B_014_LodgeScene Auto Const Mandatory

Quest Property SQ_PlayerShip Auto Const Mandatory

ObjectReference Property MQ104B_Lodge_MarkerBarrett01 Auto Const Mandatory

ObjectReference Property MQ104BLinTravelMarker Auto Const Mandatory

ObjectReference Property VecteraExteriorNPCEnableMarker001 Auto Const Mandatory

Scene Property RAS_MQ104B_006_BarrettScene Auto Const Mandatory

ReferenceAlias Property Alias_VecteraMapMarker Auto Const Mandatory

Quest Property LinEliteCrewQuest Auto Const

Quest Property HellerEliteCrewQuest Auto Const

ReferenceAlias Property Alias_SecondBarrettSlateQuestObject Auto Const Mandatory

Quest Property SQ_Companions Auto Const Mandatory

WwiseEvent Property OBJ_MQ104B_Computer_Repair Auto Const Mandatory

WwiseEvent Property OBJ_MQ104B_Power_Circuit Auto Const Mandatory

ObjectReference Property MQ104B_BarrettCell_EnableMaker Auto Const Mandatory

MiscObject Property Power_Cell Auto Const Mandatory

ObjectReference Property Frontier_ModularREF Auto Const Mandatory

ReferenceAlias Property Alias_PlayerShipPassengerMarker Auto Const Mandatory

GlobalVariable Property COM_PQ_LockedInCompanion Auto Const Mandatory

RefCollectionAlias Property Passengers Auto Const

RefCollectionAlias Property DisembarkingCrew Auto Const

Faction Property CaptiveFaction Auto Const Mandatory

Faction Property PotentialCrewFaction Auto Const Mandatory

Perk Property Crew_Demolitions Auto Const Mandatory

Perk Property Crew_Outpost_Management Auto Const Mandatory

Perk Property Crew_Geology Auto Const Mandatory

Perk Property Crew_Outpost_Engineering Auto Const Mandatory

Quest Property RAS_MQ104B Auto Const Mandatory

ObjectReference Property VecteraShipLandingMarker Auto Const

Keyword Property CurrentInteractionLinkedRefKeyword Auto Const Mandatory

ObjectReference Property LC001VecteraLiftDoor Auto Const

Perk Property TRAIT_UnwantedHero Mandatory Const Auto

Quest Property TraitUnwantedHero Mandatory Const Auto
