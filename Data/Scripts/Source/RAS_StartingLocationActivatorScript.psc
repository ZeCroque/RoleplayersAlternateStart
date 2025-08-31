Scriptname RAS_StartingLocationActivatorScript extends ObjectReference

Keyword Property LocTypeSettlement Mandatory Const Auto
Keyword Property LocTypeSurface Mandatory Const Auto
Keyword Property LocTypeOrbit Mandatory Const Auto
Location Property SettleAzureBrookFarmsLocation Mandatory Const Auto
Location Property SettleCodysHillLocation Mandatory Const Auto
Location Property SettleWaggonerFarmLocation Mandatory Const Auto
Location Property StationTheClinicSecureWingLocation Mandatory Const Auto
Location Property StationTheKeyInteriorLocation Mandatory Const Auto
Location Property CityNewAtlantisLocation Mandatory Const Auto
FormList Property RAS_ExcludedSettlementsLocationList Mandatory Const Auto
FormList Property RAS_SettlementsLocationList Mandatory Const Auto
FormList Property RAS_ExcludedStarstationsLocationList Mandatory Const Auto
FormList Property RAS_StarstationsLocationList Mandatory Const Auto

FormList Property RAS_CustomStartsList Mandatory Const Auto

TerminalMenu Property RAS_StartingLocationTerminalMenu Mandatory Const Auto
TerminalMenu Property RAS_StartingLocationTerminal_SettlementMenu Mandatory Const Auto
TerminalMenu Property RAS_StartingLocationTerminal_StarstationMenu Mandatory Const Auto

ObjectReference Property RAS_StartingLocationTerminalREF Mandatory Const Auto

CustomEvent StartChosen

Form CurrentStart
Bool CustomStart = False

Event OnCellLoad()
    Self.RegisterForRemoteEvent(RAS_StartingLocationTerminalMenu, "OnTerminalMenuItemRun")

    CurrentStart = CityNewAtlantisLocation

    RAS_ExcludedSettlementsLocationList.AddForm(SettleAzureBrookFarmsLocation) ;cut content
	RAS_ExcludedSettlementsLocationList.AddForm(SettleCodysHillLocation) ;cut content
	RAS_ExcludedSettlementsLocationList.AddForm(SettleWaggonerFarmLocation) ;does not make sense to start here
	RAS_ExcludedSettlementsLocationList.AddForm(Game.GetFormFromFile(0x38CE7, "ShatteredSpace.esm"))  ;Dazra, quest location
	RAS_ExcludedSettlementsLocationList.AddForm(None) 

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
EndEvent

Event OnActivate(ObjectReference akActionRef)
    RAS_StartingLocationTerminalREF.Activate(akActionRef)

    UpdateTerminalBodies()
    UpdateTerminalList(RAS_StartingLocationTerminalMenu, RAS_CustomStartsList, 1, 2)
    UpdateTerminalList(RAS_StartingLocationTerminal_SettlementMenu, RAS_SettlementsLocationList, 0, 1)
    UpdateTerminalList(RAS_StartingLocationTerminal_StarstationMenu, RAS_StarstationsLocationList, 0, 1)
EndEvent

Event TerminalMenu.OnTerminalMenuItemRun(TerminalMenu akSender, int auiMenuItemID, TerminalMenu akTerminalBase, ObjectReference akTerminalRef)
    If(akTerminalBase == RAS_StartingLocationTerminalMenu)
        If(auiMenuItemID > 1)
            Int index = auiMenuItemID - 2
            Form[] customStarts = RAS_CustomStartsList.GetArray()
            If(index < customStarts.Length)
                CurrentStart = customStarts[index]
                CustomStart = True
                UpdateTerminalBodies()
            EndIf
        EndIf
    ElseIf(akTerminalBase == RAS_StartingLocationTerminal_SettlementMenu)
        CurrentStart = RAS_SettlementsLocationList.GetArray()[auiMenuItemID - 1]
        CustomStart = False
        UpdateTerminalBodies()
    ElseIf(akTerminalBase == RAS_StartingLocationTerminal_StarstationMenu)
        CurrentStart = RAS_StarstationsLocationList.GetArray()[auiMenuItemID - 1]
        CustomStart = False
        UpdateTerminalBodies()
    EndIf
EndEvent

Function UpdateTerminalList(TerminalMenu akTerminalMenu, FormList akList, Int templateIndex, Int idOffset)
    akTerminalMenu.ClearDynamicMenuItems(RAS_StartingLocationTerminalREF)
    Form[] array = akList.GetArray()
    Int i = 0
    While(i < array.Length)
        Debug.Trace(array[i])
        Form[] tagReplacements = new Form[1]
        tagReplacements[0] = array[i]
        akTerminalMenu.AddDynamicMenuItem(RAS_StartingLocationTerminalREF, templateIndex, i + idOffset, tagReplacements)
        i = i + 1
    EndWhile
EndFunction

Function UpdateTerminalBodies()
    UpdateTerminalBody(RAS_StartingLocationTerminalMenu)
    UpdateTerminalBody(RAS_StartingLocationTerminal_SettlementMenu)
    UpdateTerminalBody(RAS_StartingLocationTerminal_StarstationMenu)
EndFunction

Function UpdateTerminalBody(TerminalMenu akTerminalMenu)
    akTerminalMenu.ClearDynamicBodyTextItems(RAS_StartingLocationTerminalREF)
    Form[] tagReplacements = new Form[1]
    tagReplacements[0] = CurrentStart
    akTerminalMenu.AddDynamicBodyTextItem(RAS_StartingLocationTerminalREF, 0, 0, tagReplacements)
EndFunction

Function TriggerStart()
    If(CustomStart)
        var[] eventParams = new var[1]
        eventParams[0] = CurrentStart
        Self.SendCustomEvent("StartChosen", eventParams)
    Else
        ;TODO
    EndIf
EndFunction