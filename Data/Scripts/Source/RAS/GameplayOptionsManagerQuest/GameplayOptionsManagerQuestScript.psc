Scriptname RAS:GameplayOptionsManagerQuest:GameplayOptionsManagerQuestScript extends Quest

GameplayOption Property RAS_MQTriggerChanceOption Mandatory Const Auto
GlobalVariable Property RAS_MQTriggerChance Mandatory Const Auto
GameplayOption Property RAS_MQLevelThresholdOption Mandatory Const Auto
GlobalVariable Property RAS_MQLevelThreshold Mandatory Const Auto
GameplayOption Property RAS_BrokenShipRepairCostOption Mandatory Const Auto
GlobalVariable Property RAS_BrokenShipQuest_ShiptechRepairCost Mandatory Const Auto
Quest Property RAS_BrokenShipQuest Mandatory Const Auto
GameplayOption Property RAS_BrokenShipMapMarkerOption Mandatory Const Auto
GameplayOption Property RAS_ShipwreckedMapMarkerOption Mandatory Const Auto
Quest Property RAS_ShipwreckedRescueQuest Mandatory Const Auto

Event OnQuestInit()
    RegisterForGameplayOptionChangedEvent()
EndEvent

Event OnGameplayOptionChanged(GameplayOption[] aChangedOptions)
    Int optionIndex = aChangedOptions.Find(RAS_MQTriggerChanceOption)
    If(optionIndex != -1)
        If(aChangedOptions[optionIndex].GetValue() == 0)
            RAS_MQTriggerChance.SetValueInt(0)
        ElseIf(aChangedOptions[optionIndex].GetValue() == 1)
            RAS_MQTriggerChance.SetValueInt(10)
        ElseIf(aChangedOptions[optionIndex].GetValue() == 2)
            RAS_MQTriggerChance.SetValueInt(25)
        ElseIf(aChangedOptions[optionIndex].GetValue() == 3)
            RAS_MQTriggerChance.SetValueInt(33)
        ElseIf(aChangedOptions[optionIndex].GetValue() == 4)
            RAS_MQTriggerChance.SetValueInt(50)
        ElseIf(aChangedOptions[optionIndex].GetValue() == 5)
            RAS_MQTriggerChance.SetValueInt(100)
        EndIf
    EndIf
    
    optionIndex = aChangedOptions.Find(RAS_MQLevelThresholdOption)
    If(optionIndex != -1)
        If(aChangedOptions[optionIndex].GetValue() == 0)
            RAS_MQLevelThreshold.SetValueInt(1)
        ElseIf(aChangedOptions[optionIndex].GetValue() == 1)
            RAS_MQLevelThreshold.SetValueInt(5)
        ElseIf(aChangedOptions[optionIndex].GetValue() == 2)
            RAS_MQLevelThreshold.SetValueInt(10)
        ElseIf(aChangedOptions[optionIndex].GetValue() == 3)
            RAS_MQLevelThreshold.SetValueInt(25)
        ElseIf(aChangedOptions[optionIndex].GetValue() == 4)
            RAS_MQLevelThreshold.SetValueInt(50)
        EndIf
    EndIf

    optionIndex = aChangedOptions.Find(RAS_BrokenShipRepairCostOption)
    If(optionIndex != -1)
        If(aChangedOptions[optionIndex].GetValue() == 0)
            RAS_BrokenShipQuest_ShiptechRepairCost.SetValueInt(1000)
        ElseIf(aChangedOptions[optionIndex].GetValue() == 1)
            RAS_BrokenShipQuest_ShiptechRepairCost.SetValueInt(10000)
        ElseIf(aChangedOptions[optionIndex].GetValue() == 2)
            RAS_BrokenShipQuest_ShiptechRepairCost.SetValueInt(25000)
        ElseIf(aChangedOptions[optionIndex].GetValue() == 3)
            RAS_BrokenShipQuest_ShiptechRepairCost.SetValueInt(50000)
        EndIf
        RAS_BrokenShipQuest.UpdateCurrentInstanceGlobal(RAS_BrokenShipQuest_ShiptechRepairCost)
    EndIf

    optionIndex = aChangedOptions.Find(RAS_BrokenShipMapMarkerOption)
    If(optionIndex != -1)
        (RAS_BrokenShipQuest as RAS:BrokenShipQuest:BrokenShipQuestScript) .ShowMapMarkers = aChangedOptions[optionIndex].GetValue() 
    EndIf

    optionIndex = aChangedOptions.Find(RAS_ShipwreckedMapMarkerOption)
    If(optionIndex != -1)
        (RAS_ShipwreckedRescueQuest as RAS:ShipwreckedRescueQuest:ShipwreckedRescueQuestScript) .ShowMapMarkers = aChangedOptions[optionIndex].GetValue() 
    EndIf
EndEvent