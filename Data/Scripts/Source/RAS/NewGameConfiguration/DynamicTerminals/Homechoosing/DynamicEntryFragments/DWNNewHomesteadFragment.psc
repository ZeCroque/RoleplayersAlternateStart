Scriptname RAS:NewGameConfiguration:DynamicTerminals:HomeChoosing:DynamicEntryFragments:DWNNewHomesteadFragment extends Form Const

ObjectReference Property RAS_HomeChoosingTerminalREF Mandatory Const Auto
MiscObject Property RAS_DynamicEntry_Start_AtHome Mandatory Const Auto
GlobalVariable Property UC05_PlayerIsUCCitizen Mandatory Const Auto
Message Property RAS_DWNNewHomesteadFurnitureMessage Mandatory Const Auto
Keyword Property MapMarkerLinkedRefNameOverride Auto Const mandatory

Event OnInit()
    RegisterForCustomEvent(RAS_HomeChoosingTerminalREF as RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript, "SelectedFragmentTriggered")
    RegisterForCustomEvent(RAS_HomeChoosingTerminalREF as RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript, "EntryTriggered")
EndEvent

Event RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript.EntryTriggered(RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript akSender, var[] kArgs)
    If(kArgs[0] as Form == Self)
        RAS:NewGameConfiguration:DynamicTerminals:StartingLocation:DynamicEntryFragments:HouseFragment houseFragment = RAS_DynamicEntry_Start_AtHome as RAS:NewGameConfiguration:DynamicTerminals:StartingLocation:DynamicEntryFragments:HouseFragment
        houseFragment.TargetReference = Game.GetFormFromFile(0xa4c, "DWN_NewHomestead_PlayerHouse.esm") as ObjectReference
    Endif
EndEvent

Event RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript.SelectedFragmentTriggered(RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript akSender, var[] kArgs)
    If(kArgs[0] as Form == Self)      
        Game.GetPlayer().AddItem(Game.GetFormFromFile(0xc9, "DWN_NewHomestead_PlayerHouse.esm") as Key)
        UC05_PlayerIsUCCitizen.SetValueInt(1)
        
        (Game.GetFormFromFile(0xc8, "DWN_NewHomestead_PlayerHouse.esm") as GlobalVariable).SetValueInt(1)
        Quest nhHouseMainQuest = Game.GetFormFromFile(0xcb, "DWN_NewHomestead_PlayerHouse.esm") as Quest
        (nhHouseMainQuest.GetAlias(2) as ReferenceAlias).GetReference().SetLinkedRef((nhHouseMainQuest.GetAlias(4) as ReferenceAlias).GetReference(), MapMarkerLinkedRefNameOverride, True)
        If(RAS_DWNNewHomesteadFurnitureMessage.Show())
            (Game.GetFormFromFile(0xca, "DWN_NewHomestead_PlayerHouse.esm") as GlobalVariable).SetValueInt(1)
            (Game.GetFormFromFile(0xb3a, "DWN_NewHomestead_PlayerHouse.esm") as ObjectReference).Enable()
            (Game.GetFormFromFile(0x106, "DWN_NewHomestead_PlayerHouse.esm") as ObjectReference).Enable()
            (Game.GetFormFromFile(0xbd, "DWN_NewHomestead_PlayerHouse.esm") as ObjectReference).Enable()
            (Game.GetFormFromFile(0xaa6, "DWN_NewHomestead_PlayerHouse.esm") as ObjectReference).Enable()
            (Game.GetFormFromFile(0x9cb, "DWN_NewHomestead_PlayerHouse.esm") as ObjectReference).Enable()
            (Game.GetFormFromFile(0x935, "DWN_NewHomestead_PlayerHouse.esm") as ObjectReference).Enable()
            (Game.GetFormFromFile(0xb3d, "DWN_NewHomestead_PlayerHouse.esm") as ObjectReference).Enable()
        Endif
    EndIf
EndEvent        