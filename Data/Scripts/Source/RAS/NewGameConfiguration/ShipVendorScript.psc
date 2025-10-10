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

CustomEvent ShipChanged

Bool CapsGivenToUnlockVehicles = False

ObjectReference myLandingMarker 
SpaceshipReference[] shipsForSale

Int currentShipBaseFormID

Event OnLoad()
    FormList SVFAlways = Game.GetFormFromFile(0x83e, "ShipVendorFramework.esm") as FormList 
    If(SVFAlways)
        AddSVFMapToList(SVFAlways)
        AddSVFMapToList(Game.GetFormFromFile(0x83f, "ShipVendorFramework.esm") as FormList)
        AddSVFMapToList(Game.GetFormFromFile(0x840, "ShipVendorFramework.esm") as FormList )
    Else
        AddVanillaShipsToList(ShipsToSellList, Game.GetPlayer().GetLevel())
    EndIf

    LeveledSpaceshipBase[] shipArray = RAS_ShipList.GetArray(true) as LeveledSpaceshipBase[]
    myLandingMarker = GetLinkedRef(LinkShipLandingMarker01)
    shipsForSale = new SpaceshipReference[0]
    Int i = 0
    While(i < shipArray.Length)
        CreateShipForSale(shipArray[i], myLandingMarker, shipsForSale)
        i += 1
    EndWhile
                
    RegisterForMenuOpenCloseEvent("DialogueMenu")
    RegisterForMenuOpenCloseEvent("SpaceshipEditorMenu")
EndEvent

Event SpaceshipReference.OnShipBought(SpaceshipReference akSenderRef)
    RAS:ShipManagerQuest:ShipManagerQuestScript shipManagerScript = (RAS_ShipManagerQuest as RAS:ShipManagerQuest:ShipManagerQuestScript)

    Game.RemovePlayerOwnedShip(shipManagerScript.currentShip)

    If(shipManagerScript.currentShip != (RAS_ShipManagerQuest as RAS:ShipManagerQuest:ShipManagerQuestScript).RAS_NoneShipReference)
        CreateUnleveledShipForSale(Game.GetForm(currentShipBaseFormID) as SpaceshipBase, myLandingMarker, shipsForSale)
        shipManagerScript.currentShip.Disable()
    Else
        shipManagerScript.currentShip.SetLinkedRef(myLandingMarker, SpaceshipStoredLink)
        shipManagerScript.currentShip.SetActorRefOwner(self)
        shipsForSale.Add(shipManagerScript.currentShip)
    EndIf
    
    shipManagerScript.currentShip = akSenderRef

    shipsForSale.Remove(shipsForSale.Find(akSenderRef))

    If(shipManagerScript.currentShip == shipManagerScript.RAS_NoneShipReference)
        NoShipSelected = True
    Else
        NoShipSelected = False
        currentShipBaseFormID = shipManagerScript.currentShip.GetLeveledSpaceshipBase().GetFormID()
    EndIf
    Self.SendCustomEvent("ShipChanged")
    myLandingMarker.ShowHangarMenu(0, self, GetShipForSale(), True)
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

function CreateShipForSale(LeveledSpaceshipBase leveledShipToCreate, ObjectReference landingMarker, SpaceshipReference[] shipList)
    SpaceshipReference newShip = landingMarker.PlaceShipAtMe(leveledShipToCreate, aiLevelMod = 2, abInitiallyDisabled = true, akEncLoc = ShipVendorLocation)
    if newShip
        shipList.Add(newShip)
        newShip.SetLinkedRef(landingMarker, SpaceshipStoredLink)
        newShip.SetActorRefOwner(self)
        RegisterForRemoteEvent(newShip, "OnShipBought")
        newShip.RemoveAllItems()
    endif
endFunction

function CreateUnleveledShipForSale(SpaceshipBase leveledShipToCreate, ObjectReference landingMarker, SpaceshipReference[] shipList)
    SpaceshipReference newShip = landingMarker.PlaceShipAtMe(leveledShipToCreate, aiLevelMod = 2, abInitiallyDisabled = true, akEncLoc = ShipVendorLocation)
    if newShip
        shipList.Add(newShip)
        newShip.SetLinkedRef(landingMarker, SpaceshipStoredLink)
        newShip.SetActorRefOwner(self)
        RegisterForRemoteEvent(newShip, "OnShipBought")
        newShip.RemoveAllItems()
    endif
endFunction

SpaceshipReference function GetShipForSale(int index = 0)
    SpaceshipReference shipforSale = NONE
    if shipsForSale.Length > 0
        if index > -1 && index < shipsForSale.Length
            shipforSale = shipsForSale[index]
        elseif index >= shipsForSale.Length
            shipforSale = shipsForSale[shipsForSale.Length-1]
        else
            shipforSale = shipsForSale[0]
        endif
    endif
    return shipforSale
endFunction

function StartShipVending()
    RegisterForRemoteEvent((RAS_ShipManagerQuest as RAS:ShipManagerQuest:ShipManagerQuestScript).currentShip, "OnShipBought")
    myLandingMarker.ShowHangarMenu(0, self, GetShipForSale(), True)
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