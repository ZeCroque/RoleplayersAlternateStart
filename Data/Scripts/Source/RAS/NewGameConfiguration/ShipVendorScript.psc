Scriptname RAS:NewGameConfiguration:ShipVendorScript extends Actor conditional

Keyword property LinkShipLandingMarker01 auto const mandatory
{ link vendor to landing marker }

Keyword property SpaceshipStoredLink auto const mandatory
{ link ships to landing marker }
    
ShipVendorListScript property ShipsToSellListAlwaysDataset auto
{ The data set for ships that should always be available for sale. }

Location Property ShipVendorLocation Mandatory Const Auto

Quest Property RAS_NewGameManagerQuest Mandatory Const Auto

Perk Property RAS_FreeShoppingPerk Mandatory Const Auto

ConditionForm Property RAS_AreVehiclesUnlocked Mandatory Const Auto

Message Property RAS_VehicleUnlockingMessage Mandatory Const Auto

Bool CapsGivenToUnlockVehicles = False

ObjectReference myLandingMarker 
SpaceshipReference[] shipsForSale

SpaceshipReference Property currentShip Auto
Bool Property NoShipSelected Auto Conditional 
Int currentShipBaseFormID

Event OnLoad()
    myLandingMarker = GetLinkedRef(LinkShipLandingMarker01)
    shipsForSale = new SpaceshipReference[0]
    CreateShipsForSale(ShipsToSellListAlwaysDataset.ShipList, Game.GetPlayer().GetLevel(), myLandingMarker, shipsForSale)
EndEvent

Event SpaceshipReference.OnShipBought(SpaceshipReference akSenderRef)
    Game.RemovePlayerOwnedShip(currentShip)

    If(currentShip != (RAS_NewGameManagerQuest as RAS:NewGameManagerQuest:NewGameManagerQuestScript).RAS_NoneShipReference)
        CreateUnleveledShipForSale(Game.GetForm(currentShipBaseFormID) as SpaceshipBase, myLandingMarker, shipsForSale)
        currentShip.Disable()
    Else
        currentShip.SetLinkedRef(myLandingMarker, SpaceshipStoredLink)
        currentShip.SetActorRefOwner(self)
        shipsForSale.Add(currentShip)
    EndIf
    
    currentShip = akSenderRef

    shipsForSale.Remove(shipsForSale.Find(akSenderRef))

    If(currentShip == (RAS_NewGameManagerQuest as RAS:NewGameManagerQuest:NewGameManagerQuestScript).RAS_NoneShipReference)
        NoShipSelected = True
    Else
        NoShipSelected = False
        currentShipBaseFormID = currentShip.GetLeveledSpaceshipBase().GetFormID()
    EndIf
    myLandingMarker.ShowHangarMenu(0, self, GetShipForSale(), True)
EndEvent

function CreateShipsForSale(ShipVendorListScript:ShipToSell[] shipToSellList, int playerLevel, ObjectReference createMarker, SpaceshipReference[] shipList)
    int i = 0
    if shipToSellList.Length > 0
        while i < shipToSellList.Length
            ShipVendorListScript:ShipToSell theShipToSell = shipToSellList[i]
            if playerLevel >= theShipToSell.minLevel
                CreateShipForSale(theShipToSell.leveledShip, createMarker, shipList)
            endif
            i += 1
        endWhile
    endif
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
    RegisterForMenuOpenCloseEvent("SpaceshipEditorMenu")
    If(currentShip == None)
        currentShip = (RAS_NewGameManagerQuest as RAS:NewGameManagerQuest:NewGameManagerQuestScript).RAS_NoneShipReference
        RegisterForRemoteEvent(currentShip, "OnShipBought")
    EndIf
    myLandingMarker.ShowHangarMenu(0, self, GetShipForSale(), True)
endFunction

function StartShipEditing()
    RegisterForMenuOpenCloseEvent("SpaceshipEditorMenu")
    myLandingMarker.ShowHangarMenu(0, self)
endFunction

function StartVehicleVending()
    If(!RAS_AreVehiclesUnlocked.IsTrue())
        RAS_VehicleUnlockingMessage.Show()
        Game.GivePlayerCaps(25000)
        CapsGivenToUnlockVehicles = True
    EndIf
    RegisterForMenuOpenCloseEvent("SpaceshipEditorMenu")
    myLandingMarker.ShowHangarMenu(1, self)
endFunction

Event OnMenuOpenCloseEvent(string asMenuName, bool abOpening)
	If(abOpening)
        Game.GetPlayer().AddPerk(RAS_FreeShoppingPerk)
    Else
		Game.GetPlayer().RemovePerk(RAS_FreeShoppingPerk)

        If(!RAS_AreVehiclesUnlocked.IsTrue() && CapsGivenToUnlockVehicles)
            Game.GetPlayer().RemoveItem(Game.GetCaps(), 25000)
        EndIf
        CapsGivenToUnlockVehicles = False

        UnregisterForMenuOpenCloseEvent("SpaceshipEditorMenu")
	EndIf
EndEvent