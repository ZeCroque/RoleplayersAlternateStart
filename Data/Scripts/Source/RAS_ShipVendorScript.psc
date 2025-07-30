Scriptname RAS_ShipVendorScript extends Actor conditional

Keyword property LinkShipLandingMarker01 auto const mandatory
{ link vendor to landing marker }

Keyword property SpaceshipStoredLink auto const mandatory
{ link ships to landing marker }
    
ShipVendorListScript property ShipsToSellListAlwaysDataset auto
{ The data set for ships that should always be available for sale. }

Location Property ShipVendorLocation Mandatory Const Auto

ObjectReference myLandingMarker

SpaceshipReference[] shipsForSale

Event OnLoad()
    myLandingMarker = GetLinkedRef(LinkShipLandingMarker01)
    shipsForSale = new SpaceshipReference[0]
    CreateShipsForSale(ShipsToSellListAlwaysDataset.ShipList, Game.GetPlayer().GetLevel(), myLandingMarker, shipsForSale)
EndEvent

Event SpaceshipReference.OnShipBought(SpaceshipReference akSenderRef)
    debug.trace(self + " OnShipBought " + akSenderRef)
    int shipsForSaleIndex = shipsForSale.Find(akSenderRef)
    if shipsForSaleIndex > -1
        shipsForSale.Remove(shipsForSaleIndex)
    endif
    ;todo add the previous home ship to the list
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
    myLandingMarker.ShowHangarMenu(0, self, GetShipForSale(), True)
endFunction
