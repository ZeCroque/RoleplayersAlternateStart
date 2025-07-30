Scriptname RAS_ShipVendorScript extends Actor conditional

Keyword property LinkShipLandingMarker01 auto const mandatory
{ link vendor to landing marker }

Keyword property SpaceshipStoredLink auto const mandatory
{ link ships to landing marker }
    
ShipVendorListScript property ShipsToSellListAlwaysDataset auto
{ The data set for ships that should always be available for sale. }

Location Property ShipVendorLocation Mandatory Const Auto

Quest Property RAS_NewGameManagerQuest Mandatory Const Auto

ObjectReference Property RAS_TestActivator Mandatory Const Auto

ObjectReference myLandingMarker 
SpaceshipReference[] shipsForSale
SpaceshipReference Property currentShip Auto

Event OnLoad()
    myLandingMarker = GetLinkedRef(LinkShipLandingMarker01)
    shipsForSale = new SpaceshipReference[0]
    CreateShipsForSale(ShipsToSellListAlwaysDataset.ShipList, Game.GetPlayer().GetLevel(), myLandingMarker, shipsForSale)
EndEvent

Event SpaceshipReference.OnShipBought(SpaceshipReference akSenderRef)
    Game.RemovePlayerOwnedShip(currentShip)
    currentShip.SetLinkedRef(myLandingMarker, SpaceshipStoredLink)
    currentShip.SetActorRefOwner(self)
    shipsForSale.Add(currentShip)

    int shipsForSaleIndex = shipsForSale.Find(akSenderRef)
    currentShip = shipsForSale[shipsForSaleIndex]
    shipsForSale.Remove(shipsForSaleIndex)

    Game.GetPlayer().MoveTo(RAS_TestActivator) ;Force closes the menu
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
    If(currentShip == None)
        currentShip = (RAS_NewGameManagerQuest as RAS_NewGameManagerQuestScript).RAS_NoneShipReference
        RegisterForRemoteEvent(currentShip, "OnShipBought")
    EndIf
    myLandingMarker.ShowHangarMenu(0, self, GetShipForSale(), True)
endFunction
