Scriptname RAS:NewGameManagerQuest:PlayerAliasScript extends ReferenceAlias

Quest Property RAS_MQReplacerQuest Mandatory Const Auto
Quest Property MQ101 Mandatory Const Auto
Quest Property RAS_MQ101 Mandatory Const Auto
Quest Property RAS_ShipManagerQuest Mandatory Const Auto
Location Property VecteraMineLocation Mandatory Const Auto
ReferenceAlias Property Heller Mandatory Const Auto
Keyword Property AnimFlavorTechReader Mandatory Const Auto
FormList Property RAS_TmpItemsToEquipBack Mandatory Const Auto
Actor Property RAS_ShipServicesActorREF Mandatory Const Auto
ObjectReference Property RAS_HomeChoosingTerminalREF Mandatory Const Auto
ObjectReference Property RAS_NarrativeAdjustmentsActivatorREF Mandatory Const Auto
ObjectReference Property RAS_StartingStuffContainer Mandatory Const Auto

Event OnInit()
    AddInventoryEventFilter(None)
EndEvent

Event OnPlayerLoadGame()
    ;Forces dynamic terminals to update after reloading the game
    (GetOwningQuest() as RAS:NewGameManagerQuest:NewGameManagerQuestScript).HandleConfigurationChanged(None)
EndEvent

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
    If(akNewLoc)
        If(GetOwningQuest().GetStage() == 11)
            ;Setting up new game after player left Unity

            (GetOwningQuest() as RAS:NewGameManagerQuest:NewGameManagerQuestScript).RestoreItems()

            ;Advancing quests
            GetOwningQuest().SetStage(100)
            RAS_MQReplacerQuest.SetStage(0)

            ;If player has picked a ship, clear unity ship vendor event listeners and setup the bought ship
            RAS:NewGameConfiguration:ShipVendorScript vendorScript = RAS_ShipServicesActorREF as RAS:NewGameConfiguration:ShipVendorScript
            vendorScript.UnregisterFromEvents()
            RAS:ShipManagerQuest:ShipManagerQuestScript shipManagerScript = (RAS_ShipManagerQuest as RAS:ShipManagerQuest:ShipManagerQuestScript)
            If(shipManagerScript.currentShip != shipManagerScript.RAS_NoneShipReference) 
                shipManagerScript.SetupPlayerShip(shipManagerScript.currentShip)
            EndIf

            ;If player picked a home, give it to them
            (RAS_HomeChoosingTerminalREF as RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript).CallSelectedFragment()

            ;Triggers narrative adjustments
            (RAS_NarrativeAdjustmentsActivatorREF as RAS:NewGameConfiguration:DynamicTerminals:NarrativeAdjustments:NarrativeAdjustmentsActivatorScript).TriggerAllValidFragment()
            Clear()
        ; ElseIf(akNewLoc == VecteraMineLocation && GetOwningQuest().GetStage() == 5)
        ;     ;Vanilla start
        ;     GetOwningQuest().Stop()
        ;     MQ101.SetObjectiveDisplayed(5, True, True)
        ;     Heller.GetReference().RemoveKeyword(AnimFlavorTechReader)
        ;     Heller.GetReference().Reset(Game.GetPlayer())
        ;     Clear()
        Endif
    EndIf
EndEvent

; Event OnItemUnequipped(Form akBaseObject, ObjectReference akReference)
;     If((GetOwningQuest() as RAS:NewGameManagerQuest:NewGameManagerQuestScript).StarbornVanillaStart && RAS_MQ101.GetStageDone(25) == False)
;         RAS_TmpItemsToEquipBack.AddForm(akBaseObject)
;     EndIf
; EndEvent

; Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer, int aiTransferReason)
;     If(Utility.IntToHex(akBaseItem.GetFormID()) > 0x01000000) ;Non vanilla (can be DLC)
;         RAS_StartingStuffContainer.AddItem(akBaseItem, aiItemCount)
;     EndIf
; EndEvent