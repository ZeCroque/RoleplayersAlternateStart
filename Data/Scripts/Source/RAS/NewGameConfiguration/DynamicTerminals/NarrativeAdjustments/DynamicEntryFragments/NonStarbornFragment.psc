Scriptname RAS:NewGameConfiguration:DynamicTerminals:NarrativeAdjustments:DynamicEntryFragments:NonStarbornFragment extends MiscObject

ObjectReference Property RAS_NarrativeAdjustmentsActivatorREF Mandatory Const Auto
GlobalVariable Property RAS_DisableStarborn Mandatory Const Auto

Event OnInit()
    RegisterForCustomEvent(RAS_NarrativeAdjustmentsActivatorREF as RAS:NewGameConfiguration:DynamicTerminals:NarrativeAdjustments:NarrativeAdjustmentsActivatorScript, "FragmentStateChanged")
EndEvent

Event RAS:NewGameConfiguration:DynamicTerminals:NarrativeAdjustments:NarrativeAdjustmentsActivatorScript.FragmentStateChanged(RAS:NewGameConfiguration:DynamicTerminals:NarrativeAdjustments:NarrativeAdjustmentsActivatorScript akSender, var[] kArgs)
    If(kArgs[0] as Form == Self)
        RAS_DisableStarborn.SetValueInt(kArgs[1] as Int)
    Endif
EndEvent