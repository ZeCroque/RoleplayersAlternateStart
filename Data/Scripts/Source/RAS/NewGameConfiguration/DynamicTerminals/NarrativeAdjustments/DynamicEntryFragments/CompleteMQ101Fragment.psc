Scriptname RAS:NewGameConfiguration:DynamicTerminals:NarrativeAdjustments:DynamicEntryFragments:CompleteMQ101Fragment extends MiscObject

ObjectReference Property RAS_NarrativeAdjustmentsActivatorREF Mandatory Const Auto
Quest Property RAS_NewGameManagerQuest Mandatory Const Auto

Event OnInit()
    RegisterForCustomEvent(RAS_NarrativeAdjustmentsActivatorREF as RAS:NewGameConfiguration:DynamicTerminals:NarrativeAdjustments:NarrativeAdjustmentsActivatorScript, "FragmentTriggered")
EndEvent

Event RAS:NewGameConfiguration:DynamicTerminals:NarrativeAdjustments:NarrativeAdjustmentsActivatorScript.FragmentTriggered(RAS:NewGameConfiguration:DynamicTerminals:NarrativeAdjustments:NarrativeAdjustmentsActivatorScript akSender, var[] kArgs)
    If(kArgs[0] as Form == Self)
        RAS:NewGameManagerQuest:NewGameManagerQuestScript managerQuest = RAS_NewGameManagerQuest as RAS:NewGameManagerQuest:NewGameManagerQuestScript
        managerQuest.PreventMQ101FirstStage()
        managerQuest.HookMQ()
    Endif
EndEvent