Scriptname RAS:NewGameConfiguration:ShipVendorScript extends Actor conditional

Keyword property LinkShipLandingMarker01 auto const mandatory
{ link vendor to landing marker }

Keyword property SpaceshipStoredLink auto const mandatory
{ link ships to landing marker }
    
ShipVendorListScript[] property ShipsToSellList auto
{ The data set for ships that should always be available for sale. }

Location Property ShipVendorLocation Mandatory Const Auto

Quest Property RAS_ShipManagerQuest Mandatory Const Auto

Perk Property RAS_FreeShoppingPerk Mandatory Const Auto

ConditionForm Property RAS_AreVehiclesUnlocked Mandatory Const Auto

Message Property RAS_VehicleUnlockingMessage Mandatory Const Auto

Bool Property NoShipSelected Auto Conditional 
{ If the currently owned ship is the none ship, this boolean is true (Not a dupe of pedestrian as it's updated right away and not upo entering black hole) }

FormList Property RAS_ShipList Mandatory Const Auto
ActorValue Property RAS_ShipBaseIndex Mandatory Const Auto

Faction Property CrimeFactionCrimsonFleet Mandatory Const Auto
Faction Property VaruunFaction Mandatory Const Auto
ObjectReference Property RAS_AnomalyActivatorREF01 Mandatory Const Auto
Message Property RAS_ShiptechNotReadyMessage Mandatory Const Auto
Message Property RAS_ShiptechTutorialMessage Mandatory Const Auto
Quest Property SQ_PlayerShip Mandatory Const Auto

CustomEvent ShipChanged
Guard ShipListGuard ProtectsFunctionLogic

Bool CapsGivenToUnlockVehicles = False

ObjectReference myLandingMarker 
RefCollectionAlias shipsToSell

Int currentShipBaseIndex

Bool ShipTechTutorialShown = False
Bool AwaitingLevelUpdate = False

Function InitShipsList() RequiresGuard(ShipListGuard)
    FormList SVFAlways = Game.GetFormFromFile(0x83e, "ShipVendorFramework.esm") as FormList 
    If(SVFAlways)
        AddSVFMapToList(SVFAlways)
        AddSVFMapToList(Game.GetFormFromFile(0x83f, "ShipVendorFramework.esm") as FormList)
        AddSVFMapToList(Game.GetFormFromFile(0x840, "ShipVendorFramework.esm") as FormList )
    Else
        AddVanillaShipsToList(ShipsToSellList, Game.GetPlayer().GetLevel())
    EndIf
EndFunction

Function GenerateShips() RequiresGuard(ShipListGuard)
    shipsToSell = (RAS_ShipManagerQuest as RAS:ShipManagerQuest:ShipManagerQuestScript).ShipsToSell
    LeveledSpaceshipBase[] shipArray = RAS_ShipList.GetArray() as LeveledSpaceshipBase[]
    Int i = 0
    While(i < shipArray.Length)
        CreateShipForSale(shipArray[i], myLandingMarker, i)
        i += 1
    EndWhile
EndFunction

Function ClearShips() RequiresGuard(ShipListGuard) 
    While(shipsToSell.GetCount())
        SpaceshipReference ship = shipsToSell.GetAt(0) as SpaceshipReference
        ship.SetLinkedRef(None, SpaceshipStoredLink)
        ship.SetActorRefOwner(None)
        ship.Disable()
        shipsToSell.RemoveRef(ship)
    EndWhile
EndFunction

Event OnLoad()
    RegisterForMenuOpenCloseEvent("DialogueMenu")
    RegisterForMenuOpenCloseEvent("SpaceshipEditorMenu")
    Self.RegisterForCustomEvent(RAS_AnomalyActivatorREF01 as RAS:NewGameConfiguration:ManageLevelActivatorScript, "PlayerLeveledUp")
    
    myLandingMarker = GetLinkedRef(LinkShipLandingMarker01)
    LockGuard ShipListGuard
        BlockActivation(True, False)
        InitShipsList()
        GenerateShips()
        BlockActivation(False, False)
    EndLockGuard
EndEvent

Event RAS:NewGameConfiguration:ManageLevelActivatorScript.PlayerLeveledUp(RAS:NewGameConfiguration:ManageLevelActivatorScript akSender, var[] akArgs)
    If(!AwaitingLevelUpdate)
        AwaitingLevelUpdate = True
        LockGuard ShipListGuard
            AwaitingLevelUpdate = False
            BlockActivation(True, False)
            ClearShips()
            GenerateShips()
            BlockActivation(False, False)
        EndLockGuard
    EndIf
EndEvent

Event OnActivate(ObjectReference akActionRef)
    If(!ShipTechTutorialShown)
        ShipTechTutorialShown = True        
        RAS_ShiptechTutorialMessage.Show()
    EndIf
    
    TryLockGuard ShipListGuard
    Else
        RAS_ShiptechNotReadyMessage.Show()
    EndTryLockGuard
EndEvent

Event SpaceshipReference.OnShipBought(SpaceshipReference akSenderRef)
    RAS:ShipManagerQuest:ShipManagerQuestScript shipManagerScript = (RAS_ShipManagerQuest as RAS:ShipManagerQuest:ShipManagerQuestScript)

    SQ_PlayerShipScript playerShipQuest = SQ_PlayerShip as SQ_PlayerShipScript
    playerShipQuest.ResetHomeShip(akSenderRef)
    playerShipQuest.PlayerShips.RemoveRef(shipManagerScript.currentShip)
    Game.RemovePlayerOwnedShip(shipManagerScript.currentShip)

    If(shipManagerScript.currentShip != (RAS_ShipManagerQuest as RAS:ShipManagerQuest:ShipManagerQuestScript).RAS_NoneShipReference)
        shipManagerScript.currentShip.Disable()
        CreateShipForSale(RAS_ShipList.GetAt(currentShipBaseIndex) as LeveledSpaceshipBase, myLandingMarker, currentShipBaseIndex)
    Else
        shipManagerScript.currentShip.SetLinkedRef(myLandingMarker, SpaceshipStoredLink)
        shipManagerScript.currentShip.SetActorRefOwner(self)
        shipsToSell.AddRef(shipManagerScript.currentShip)
    EndIf
    
    shipManagerScript.currentShip = akSenderRef
    Int shipIndex = akSenderRef.GetValueInt(RAS_ShipBaseIndex)
    shipsToSell.RemoveRef(akSenderRef)

    If(shipManagerScript.currentShip == shipManagerScript.RAS_NoneShipReference)
        NoShipSelected = True
    Else
        NoShipSelected = False
        currentShipBaseIndex = shipIndex 
    EndIf
    Self.SendCustomEvent("ShipChanged")
    myLandingMarker.ShowHangarMenu(0, self, shipsToSell.GetAt(0) as SpaceshipReference, True)
EndEvent

Function AddSVFMapToList(FormList akMap)
    Int i = 0
    Int j = 0
    Int k = 0
    FormList[] map = akMap.GetArray() as FormList[]
    While(i < map.Length)
        FormList[] vendorLists = map[i].GetArray() as FormList[]
        j = 0
        While(j < vendorLists.Length)
            LeveledSpaceshipBase[] ships = vendorLists[j].GetArray() as LeveledSpaceshipBase[]
            k = 0
            While(k < ships.Length)
                RAS_ShipList.AddForm(ships[k])
                k += 1
            EndWhile
            j += 1
        EndWhile
        i += 1
    EndWhile
EndFunction

function AddVanillaShipsToList(ShipVendorListScript[] shipToSellList, int playerLevel)
    Int i = 0
    Int j = 0
    While(i < shipToSellList.Length)
        j = 0
        while j < shipToSellList[i].ShipList.Length
            ShipVendorListScript:ShipToSell theShipToSell = shipToSellList[i].ShipList[j]
            if playerLevel >= theShipToSell.minLevel
                RAS_ShipList.AddForm(theShipToSell.leveledShip)
            endif
            j += 1
        endWhile
        i += 1
    EndWhile
EndFunction

function CreateShipForSale(LeveledSpaceshipBase leveledShipToCreate, ObjectReference landingMarker, Int shipBaseIndex)
    SpaceshipReference newShip = None
    newShip = landingMarker.PlaceShipAtMe(leveledShipToCreate, aiLevelMod = 2, abInitiallyDisabled = true)
    if(newShip && newShip.IsBoundGameObjectAvailable() && !newShip.IsInFaction(CrimeFactionCrimsonFleet) && !newShip.IsInFaction(VaruunFaction))
        newShip.SetLinkedRef(landingMarker, SpaceshipStoredLink)
        newShip.SetActorRefOwner(self)
        RegisterForRemoteEvent(newShip, "OnShipBought")
        newShip.RemoveAllItems()
        shipsToSell.AddRef(newShip)
        newShip.SetValue(RAS_ShipBaseIndex, shipBaseIndex)
    endif
endFunction

function StartShipVending()
    RegisterForRemoteEvent((RAS_ShipManagerQuest as RAS:ShipManagerQuest:ShipManagerQuestScript).currentShip, "OnShipBought")
    myLandingMarker.ShowHangarMenu(0, self, shipsToSell.GetAt(0) as SpaceshipReference, True)
endFunction

function StartShipEditing()
    myLandingMarker.ShowHangarMenu(0, self)
endFunction

function StartVehicleVending()
    If(!RAS_AreVehiclesUnlocked.IsTrue())
        RAS_VehicleUnlockingMessage.Show()
        Game.GivePlayerCaps(25000)
        CapsGivenToUnlockVehicles = True
    EndIf

    myLandingMarker.ShowHangarMenu(1, self)
endFunction

Function UnregisterFromEvents()
    UnregisterForMenuOpenCloseEvent("DialogueMenu")
    UnregisterForMenuOpenCloseEvent("SpaceshipEditorMenu")
EndFunction

Event OnMenuOpenCloseEvent(string asMenuName, bool abOpening)
    If(asMenuName == "SpaceshipEditorMenu")
        If(!abOpening && !RAS_AreVehiclesUnlocked.IsTrue() && CapsGivenToUnlockVehicles)
            Game.GetPlayer().RemoveItem(Game.GetCaps(), 25000)
            CapsGivenToUnlockVehicles = False
        EndIf
    ElseIf(asMenuName == "DialogueMenu")
        If(abOpening)
            Game.GetPlayer().AddPerk(RAS_FreeShoppingPerk)
        Else
            Game.GetPlayer().RemovePerk(RAS_FreeShoppingPerk)
        EndIf
    EndIf
EndEvent