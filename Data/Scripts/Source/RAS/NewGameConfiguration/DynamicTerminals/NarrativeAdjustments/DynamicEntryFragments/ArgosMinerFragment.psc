Scriptname RAS:NewGameConfiguration:DynamicTerminals:NarrativeAdjustments:DynamicEntryFragments:ArgosMinerFragment extends MiscObject

ObjectReference Property RAS_NarrativeAdjustmentsActivatorREF Mandatory Const Auto
ActorValue Property RAS_MinerStart Mandatory Const Auto

Event OnInit()
    RegisterForCustomEvent(RAS_NarrativeAdjustmentsActivatorREF as RAS:NewGameConfiguration:DynamicTerminals:NarrativeAdjustments:NarrativeAdjustmentsActivatorScript, "FragmentStateChanged")
EndEvent

Event RAS:NewGameConfiguration:DynamicTerminals:NarrativeAdjustments:NarrativeAdjustmentsActivatorScript.FragmentStateChanged(RAS:NewGameConfiguration:DynamicTerminals:NarrativeAdjustments:NarrativeAdjustmentsActivatorScript akSender, var[] kArgs)
    If(kArgs[0] as Form == Self)
        Game.GetPlayer().SetValue(RAS_MinerStart, kArgs[1] as Int)        
    Endif
EndEvent