Scriptname RAS:NewGameConfiguration:DynamicTerminals:HomeChoosing:DynamicEntryFragments:DWNTraitFragment extends MiscObject

ObjectReference Property RAS_HomeChoosingTerminalREF Mandatory Const Auto
MiscObject Property RAS_DynamicEntry_Start_AtHome Mandatory Const Auto
ConditionForm Property RAS_HasTraitFreestarCollectiveSettler Mandatory Const Auto
ConditionForm Property RAS_HasTraitNeonStreetRat Mandatory Const Auto

Quest AkilaQuest
Quest GagarinQuest
Quest NeonQuest


Event OnInit()
    RegisterForCustomEvent(RAS_HomeChoosingTerminalREF as RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript, "EntryTriggered")

    AkilaQuest = Game.GetFormFromFile(0xa07, "DWN_TraitStarterHomes.esm") as Quest
    GagarinQuest = Game.GetFormFromFile(0xe16, "DWN_TraitStarterHomes.esm") as Quest
    NeonQuest = Game.GetFormFromFile(0x16A, "DWN_TraitStarterHomes.esm") as Quest
EndEvent

Event RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript.EntryTriggered(RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript akSender, var[] kArgs)
    If(kArgs[0] as Form == Self)
        RAS:NewGameConfiguration:DynamicTerminals:StartingLocation:DynamicEntryFragments:HouseFragment houseFragment = RAS_DynamicEntry_Start_AtHome as RAS:NewGameConfiguration:DynamicTerminals:StartingLocation:DynamicEntryFragments:HouseFragment
        If(RAS_HasTraitFreestarCollectiveSettler.IsTrue())
            houseFragment.TargetReference = Game.GetFormFromFile(0x168, "DWN_TraitStarterHomes.esm") as ObjectReference
            houseFragment.DirectionQuest = AkilaQuest
            houseFragment.DirectionQuestStage = 10
        ElseIf(RAS_HasTraitNeonStreetRat.IsTrue())
            houseFragment.TargetReference = Game.GetFormFromFile(0x161, "DWN_TraitStarterHomes.esm") as ObjectReference
            houseFragment.DirectionQuest = NeonQuest
            houseFragment.DirectionQuestStage = 10
        Else
            houseFragment.TargetReference = Game.GetFormFromFile(0xcca, "DWN_TraitStarterHomes.esm") as ObjectReference
            houseFragment.DirectionQuest = GagarinQuest
            houseFragment.DirectionQuestStage = 10
        EndIf
    Endif
EndEvent
