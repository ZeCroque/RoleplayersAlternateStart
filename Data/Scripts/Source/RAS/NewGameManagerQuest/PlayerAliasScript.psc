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
GlobalVariable Property RAS_DisableStarborn Mandatory Const Auto
ActorValue Property PlayerUnityTimesEntered Mandatory Const Auto

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

            ;Advancing quest
            GetOwningQuest().SetStage(100)

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
            
            RAS:NewGameManagerQuest:NewGameManagerQuestScript managerQuest = GetOwningQuest() as RAS:NewGameManagerQuest:NewGameManagerQuestScript
            If(!managerQuest.StarbornStart)
                managerQuest.CustomStartSetup()   
                RAS_MQReplacerQuest.SetStage(0)
            ElseIf(managerQuest.StarbornStart && RAS_DisableStarborn.GetValueInt() == 0)
                managerQuest.CustomStarbornStartSetup()
            Else                
                ;TODO save PlayerUnityTimesEntered in duplicate var and restore it on mq305
                Game.GetPlayer().SetValue(PlayerUnityTimesEntered, 0.0)
                managerQuest.CustomStartSetup()       
                RAS_MQReplacerQuest.SetStage(0)
            EndIf

            Clear()
        Endif
    EndIf
EndEvent