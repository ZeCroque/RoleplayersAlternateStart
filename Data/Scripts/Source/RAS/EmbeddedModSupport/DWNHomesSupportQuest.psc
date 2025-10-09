Scriptname RAS:EmbeddedModSupport:DWNHomesSupportQuest extends Quest

Import RAS:NewGameConfiguration:DynamicTerminals:Base:EntryStruct

MiscObject Property RAS_DynamicEntriesList_DWNHome Mandatory Const Auto
MiscObject Property RAS_DynamicEntry_Home_DWNEarthDomeFragment Mandatory Const Auto
GlobalVariable Property RAS_DynamicTerminalIndex_Home_DWNDome Mandatory Const Auto
MiscObject Property RAS_DynamicEntry_Home_DWNParadisoFragment Mandatory Const Auto
GlobalVariable Property RAS_DynamicTerminalIndex_Home_DWNParadiso Mandatory Const Auto
MiscObject Property RAS_DynamicEntry_Home_DWNVolIIHotelFragment Mandatory Const Auto
GlobalVariable Property RAS_DynamicTerminalIndex_Home_DWNVolIIHotel Mandatory Const Auto
MiscObject Property RAS_DynamicEntry_Home_DWNNewHomesteadFragment Mandatory Const Auto
GlobalVariable Property RAS_DynamicTerminalIndex_Home_DWNNewHomestead Mandatory Const Auto
MiscObject Property RAS_DynamicEntry_Home_DWNAkilaHouseFragment Mandatory Const Auto
GlobalVariable Property RAS_DynamicTerminalIndex_Home_DWNAkilaHouse Mandatory Const Auto
MiscObject Property RAS_DynamicEntry_Home_DWNNeonApartmentFragment Mandatory Const Auto
GlobalVariable Property RAS_DynamicTerminalIndex_Home_DWNNeonApartment Mandatory Const Auto
MiscObject Property RAS_DynamicEntry_Home_DWNTraitFragment Mandatory Const Auto
GlobalVariable Property RAS_DynamicTerminalIndex_Home_DWNTrait Mandatory Const Auto

Event OnQuestInit()
    Int entryCount = 0

    ObjectReference domeRef = Game.GetFormFromFile(0x2003, "DWN_EarthDomeHome.esm") as ObjectReference
    entryCount += (domeRef != None) as Int
    Key paradiseKey = Game.GetFormFromFile(0x315e, "DWN_ParadisoPlayerHome_Furnished.esm") as Key
    entryCount += (paradiseKey != None) as Int
    GlobalVariable neonHotelGlob = Game.GetFormFromFile(0x5cfa, "DWN_NeonHotelApt.esm") as GlobalVariable
    entryCount += (neonHotelGlob != None) as Int
    GlobalVariable nhGlob = Game.GetFormFromFile(0x60c8, "DWN_NewHomestead_PlayerHouse.esm") as GlobalVariable
    entryCount += (nhGlob != None) as Int
    Key akilaKey = Game.GetFormFromFile(0x4dd5, "DWN_SmallAkilaHouse.esm") as Key
    entryCount += (akilaKey != None) as Int
    Key neonAptKey = Game.GetFormFromFile(0x799f, "DWN_NeonCoreApartment.esm") as Key
    entryCount += (neonAptKey != None) as Int
    Quest akilaTrait = Game.GetFormFromFile(0x8a07, "DWN_TraitStarterHomes.esm") as Quest
    entryCount += (akilaTrait != None) as Int

    Entry[] Entries = new Entry[entryCount] 
    (RAS_DynamicEntriesList_DWNHome as RAS:NewGameConfiguration:DynamicTerminals:Base:EntriesListScript).EntriesList = Entries
    Int i = 0
    If(domeRef)
        (RAS_DynamicEntry_Home_DWNEarthDomeFragment as RAS:NewGameConfiguration:DynamicTerminals:HomeChoosing:DynamicEntryFragments:DefaultFragment).TargetReference = domeRef
        Entries[i] = new Entry
        Entries[i].Fragment = RAS_DynamicEntry_Home_DWNEarthDomeFragment
        Entries[i].Index = RAS_DynamicTerminalIndex_Home_DWNDome
        i += 1
    EndIf
    If(paradiseKey)
        RAS:NewGameConfiguration:DynamicTerminals:HomeChoosing:DynamicEntryFragments:DefaultFragment defaultFragment = RAS_DynamicEntry_Home_DWNParadisoFragment as RAS:NewGameConfiguration:DynamicTerminals:HomeChoosing:DynamicEntryFragments:DefaultFragment
        defaultFragment.TargetReference = Game.GetFormFromFile(0x3062, "DWN_ParadisoPlayerHome_Furnished.esm") as ObjectReference
        defaultFragment.UnlockKey = paradiseKey
        Entries[i] = new Entry
        Entries[i].Fragment = RAS_DynamicEntry_Home_DWNParadisoFragment
        Entries[i].Index = RAS_DynamicTerminalIndex_Home_DWNParadiso
        i += 1
    EndIf    
    If(neonHotelGlob)
        RAS:NewGameConfiguration:DynamicTerminals:HomeChoosing:DynamicEntryFragments:DefaultFragment defaultFragment = RAS_DynamicEntry_Home_DWNVolIIHotelFragment as RAS:NewGameConfiguration:DynamicTerminals:HomeChoosing:DynamicEntryFragments:DefaultFragment
        defaultFragment.TargetReference =  Game.GetFormFromFile(0x5ac9, "DWN_NeonHotelApt.esm") as ObjectReference
        defaultFragment.UnlockGlobal = neonHotelGlob
        defaultFragment.UnlockKey = Game.GetFormFromFile(0x5cfd, "DWN_NeonHotelApt.esm") as Key
        Entries[i] = new Entry
        Entries[i].Fragment = RAS_DynamicEntry_Home_DWNVolIIHotelFragment
        Entries[i].Index = RAS_DynamicTerminalIndex_Home_DWNVolIIHotel
        i += 1
    EndIf        
    If(nhGlob)
        RAS:NewGameConfiguration:DynamicTerminals:HomeChoosing:DynamicEntryFragments:DefaultFragment defaultFragment = RAS_DynamicEntry_Home_DWNNewHomesteadFragment as RAS:NewGameConfiguration:DynamicTerminals:HomeChoosing:DynamicEntryFragments:DefaultFragment
        defaultFragment.TargetReference = Game.GetFormFromFile(0x60cd, "DWN_NewHomestead_PlayerHouse.esm") as ObjectReference
        defaultFragment.UnlockGlobal = nhGlob
        Entries[i] = new Entry
        Entries[i].Fragment = RAS_DynamicEntry_Home_DWNNewHomesteadFragment
        Entries[i].Index = RAS_DynamicTerminalIndex_Home_DWNNewHomestead
        i += 1
    EndIf    
    If(akilaKey)
        RAS:NewGameConfiguration:DynamicTerminals:HomeChoosing:DynamicEntryFragments:DefaultFragment defaultFragment = RAS_DynamicEntry_Home_DWNAkilaHouseFragment as RAS:NewGameConfiguration:DynamicTerminals:HomeChoosing:DynamicEntryFragments:DefaultFragment
        defaultFragment.TargetReference = Game.GetFormFromFile(0x4dd3, "DWN_SmallAkilaHouse.esm") as ObjectReference
        defaultFragment.UnlockKey = akilaKey
        Entries[i] = new Entry
        Entries[i].Fragment = RAS_DynamicEntry_Home_DWNAkilaHouseFragment
        Entries[i].Index = RAS_DynamicTerminalIndex_Home_DWNAkilaHouse
        i += 1
    EndIf      
    If(neonAptKey)
        RAS:NewGameConfiguration:DynamicTerminals:HomeChoosing:DynamicEntryFragments:DefaultFragment defaultFragment = RAS_DynamicEntry_Home_DWNNeonApartmentFragment as RAS:NewGameConfiguration:DynamicTerminals:HomeChoosing:DynamicEntryFragments:DefaultFragment
        defaultFragment.TargetReference = Game.GetFormFromFile(0x7cf1, "DWN_NeonCoreApartment.esm") as ObjectReference
        defaultFragment.UnlockKey = neonAptKey
        Entries[i] = new Entry
        Entries[i].Fragment = RAS_DynamicEntry_Home_DWNNeonApartmentFragment
        Entries[i].Index = RAS_DynamicTerminalIndex_Home_DWNNeonApartment
        i += 1
    EndIf    
    If(akilaTrait)
        RAS:NewGameConfiguration:DynamicTerminals:HomeChoosing:DynamicEntryFragments:DefaultFragment defaultFragment = RAS_DynamicEntry_Home_DWNTraitFragment as RAS:NewGameConfiguration:DynamicTerminals:HomeChoosing:DynamicEntryFragments:DefaultFragment
        ;defaultFragment.TargetReference = target
        ;defaultFragment.UnlockKey = paradiseKey
        Entries[i] = new Entry
        Entries[i].Fragment = RAS_DynamicEntry_Home_DWNTraitFragment
        Entries[i].Index = RAS_DynamicTerminalIndex_Home_DWNTrait
        i += 1
    EndIf      
EndEvent