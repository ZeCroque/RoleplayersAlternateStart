Scriptname RAS:NewGameConfiguration:DynamicTerminals:NarrativeAdjustments:DynamicEntryFragments:ItemFragment_TEMPLATE extends MiscObject

ObjectReference Property RAS_NarrativeAdjustmentsActivatorREF Mandatory Const Auto

Event OnInit()
    RegisterForCustomEvent(RAS_NarrativeAdjustmentsActivatorREF as RAS:NewGameConfiguration:DynamicTerminals:NarrativeAdjustments:NarrativeAdjustmentsActivatorScript, "FragmentTriggered")
EndEvent

Event RAS:NewGameConfiguration:DynamicTerminals:NarrativeAdjustments:NarrativeAdjustmentsActivatorScript.FragmentTriggered(RAS:NewGameConfiguration:DynamicTerminals:NarrativeAdjustments:NarrativeAdjustmentsActivatorScript akSender, var[] kArgs)
    If(kArgs[0] as Form == Self)
        ;Add your code here
    Endif
EndEvent