Scriptname RAS_NA_DynamicEntryItem_BaseScript extends MiscObject

ObjectReference Property RAS_NarrativeAdjustmentsActivatorREF Mandatory Const Auto

Event OnInit()
    RegisterForCustomEvent(RAS_NarrativeAdjustmentsActivatorREF as RAS_NarrativeAdjustmentActScript, "FragmentTriggered")
EndEvent

Event RAS_NarrativeAdjustmentActScript.FragmentTriggered(RAS_NarrativeAdjustmentActScript akSender, var[] kArgs)
    If(kArgs[0] as Form == Self)
        ;Add your code here
    Endif
EndEvent