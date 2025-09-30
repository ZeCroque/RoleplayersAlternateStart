Scriptname RAS:NewGameConfiguration:DynamicTerminals:StartingLocation:StartingLocationActivatorScript extends ObjectReference

Keyword Property LocTypeSettlement Mandatory Const Auto
Keyword Property LocTypeSurface Mandatory Const Auto
Keyword Property LocTypeOrbit Mandatory Const Auto
Location Property SettleAzureBrookFarmsLocation Mandatory Const Auto
Location Property SettleCodysHillLocation Mandatory Const Auto
Location Property SettleWaggonerFarmLocation Mandatory Const Auto
Location Property StationTheClinicSecureWingLocation Mandatory Const Auto
Location Property StationTheKeyInteriorLocation Mandatory Const Auto
Location Property SettleCrucibleLocation Mandatory Const Auto
Location Property CityNewAtlantisLocation Mandatory Const Auto
FormList Property RAS_ExcludedSettlementsLocationList Mandatory Const Auto
FormList Property RAS_SettlementsLocationList Mandatory Const Auto
FormList Property RAS_ExcludedStarstationsLocationList Mandatory Const Auto
FormList Property RAS_StarstationsLocationList Mandatory Const Auto

FormList Property RAS_StartsList Mandatory Const Auto
MiscObject Property RAS_DynamicEntry_Start_Default Mandatory Const Auto
MiscObject Property RAS_DynamicEntry_Start_AtHome Mandatory Const Auto
MiscObject Property RAS_DynamicEntry_Start_AtDreamHome Mandatory Const Auto
MiscObject Property RAS_DynamicEntry_Start_AtParents Mandatory Const Auto
Perk Property Trait_KidStuff Mandatory Const Auto
Perk Property TRAIT_StarterHome Mandatory Const Auto
ObjectReference Property RAS_HomeChoosingTerminalREF Mandatory Const Auto

ObjectReference Property RAS_StartingLocationTerminalREF Mandatory Const Auto

Guard Initializing ProtectsFunctionLogic
Bool YetInit = False

Event OnCellLoad()    
    (RAS_DynamicEntry_Start_Default as RAS:NewGameConfiguration:DynamicTerminals:StartingLocation:DynamicEntryFragments:DefaultMoveToLocFragment).TargetLocation = CityNewAtlantisLocation

    Actor PlayerRef = Game.GetPlayer()
    If(PlayerRef.HasPerk(Trait_KidStuff))
        RAS_StartsList.AddForm(RAS_DynamicEntry_Start_AtParents)
    EndIf

    If(PlayerRef.HasPerk(TRAIT_StarterHome))
        RAS_StartsList.AddForm(RAS_DynamicEntry_Start_AtDreamHome)
    EndIf
EndEvent

Event OnActivate(ObjectReference akActionRef)
    If((RAS_HomeChoosingTerminalREF as RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript).HasValidSelection)
        RAS_StartsList.AddForm(RAS_DynamicEntry_Start_AtHome)
    EndIf
    (RAS_StartingLocationTerminalREF as RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript).Start()
EndEvent

Function InitStarts()
    LockGuard Initializing
        If(!YetInit)
            YetInit = True

            RAS_ExcludedSettlementsLocationList.AddForm(SettleAzureBrookFarmsLocation) ;cut content
            RAS_ExcludedSettlementsLocationList.AddForm(SettleCodysHillLocation) ;cut content
            RAS_ExcludedSettlementsLocationList.AddForm(SettleWaggonerFarmLocation) ;does not make sense to start here
            RAS_ExcludedSettlementsLocationList.AddForm(Game.GetFormFromFile(0x38CE7, "ShatteredSpace.esm"))  ;Dazra, quest location
            RAS_ExcludedSettlementsLocationList.AddForm(SettleCrucibleLocation) ;quest location

            RAS_ExcludedStarstationsLocationList.AddForm(StationTheClinicSecureWingLocation) ;quest location
            RAS_ExcludedStarstationsLocationList.AddForm(StationTheKeyInteriorLocation) ;quest location

            Keyword[] keywords = new Keyword[1]
            keywords[0] = LocTypeSettlement
            Location[] allSettlements = Game.GetMatchingLocations(WantedKeywords = keywords)
            Int i = 0
            While i < allSettlements.Length
                Location[] parents = allSettlements[i].GetParentLocations()
                If(parents.Length)
                    If(parents[0].HasKeyword(LocTypeSurface)) ;looking for direct parent only to elude sub-locations
                        If(!RAS_ExcludedSettlementsLocationList.HasForm(allSettlements[i]))
                            RAS_SettlementsLocationList.AddForm(allSettlements[i])
                        EndIf
                    Else
                        Int j = 0
                        While(j < parents.Length)
                            If(parents[j].HasKeyword(LocTypeOrbit))
                                If(!RAS_ExcludedStarstationsLocationList.HasForm(allSettlements[i]))
                                    RAS_StarstationsLocationList.AddForm(allSettlements[i])
                                EndIf
                                j = parents.Length ;break
                            EndIf
                            j += 1
                        EndWhile
                    EndIf
                EndIf
                i += 1
            EndWhile
        EndIf
    EndLockGuard
EndFunction