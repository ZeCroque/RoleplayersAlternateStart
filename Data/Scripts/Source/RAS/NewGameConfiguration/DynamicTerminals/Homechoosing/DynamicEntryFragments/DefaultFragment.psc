Scriptname RAS:NewGameConfiguration:DynamicTerminals:HomeChoosing:DynamicEntryFragments:DefaultFragment extends MiscObject

ObjectReference Property RAS_HomeChoosingTerminalREF Mandatory Const Auto
MiscObject Property RAS_DynamicEntry_Start_AtHome Mandatory Const Auto

Quest Property UnlockQuest Auto
Int Property UnlockQuestStage Auto
Quest Property DirectionQuest Auto
Int Property DirectionQuestStage Auto
GlobalVariable Property UnlockGlobal Auto
Key Property UnlockKey Auto
ObjectReference Property TargetReference Auto

Event OnInit()
    RegisterForCustomEvent(RAS_HomeChoosingTerminalREF as RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript, "SelectedFragmentTriggered")
    RegisterForCustomEvent(RAS_HomeChoosingTerminalREF as RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript, "EntryTriggered")
EndEvent

Event RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript.EntryTriggered(RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript akSender, var[] kArgs)
    If(kArgs[0] as Form == Self)
        RAS:NewGameConfiguration:DynamicTerminals:StartingLocation:DynamicEntryFragments:HouseFragment houseFragment = RAS_DynamicEntry_Start_AtHome as RAS:NewGameConfiguration:DynamicTerminals:StartingLocation:DynamicEntryFragments:HouseFragment
        houseFragment.TargetReference = TargetReference
        houseFragment.DirectionQuest = DirectionQuest
        houseFragment.DirectionQuestStage = DirectionQuestStage
    Endif
EndEvent

Event RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript.SelectedFragmentTriggered(RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript akSender, var[] kArgs)
    If(kArgs[0] as Form == Self)
        If(UnlockQuest)
            UnlockQuest.SetStage(UnlockQuestStage)
        EndIf

        If(UnlockGlobal)
            UnlockGlobal.SetValueInt(1)
        EndIf

        If(UnlockKey)
            Game.GetPlayer().AddItem(UnlockKey)
        EndIf
    Endif
EndEvent
