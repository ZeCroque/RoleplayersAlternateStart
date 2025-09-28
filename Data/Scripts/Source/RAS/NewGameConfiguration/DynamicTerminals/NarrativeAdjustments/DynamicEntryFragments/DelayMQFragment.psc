Scriptname RAS:NewGameConfiguration:DynamicTerminals:NarrativeAdjustments:DynamicEntryFragments:DelayMQFragment extends MiscObject

ObjectReference Property RAS_NarrativeAdjustmentsActivatorREF Mandatory Const Auto

Terminal Property RAS_NA_MQDelayTerminal Mandatory Const Auto
Quest Property RAS_NewGameManagerQuest Mandatory Const Auto

ObjectReference MQDelayTerminal

Event OnInit()
    RegisterForCustomEvent(RAS_NarrativeAdjustmentsActivatorREF as RAS:NewGameConfiguration:DynamicTerminals:NarrativeAdjustments:NarrativeAdjustmentsActivatorScript, "FragmentTriggered")
EndEvent

Event RAS:NewGameConfiguration:DynamicTerminals:NarrativeAdjustments:NarrativeAdjustmentsActivatorScript.FragmentTriggered(RAS:NewGameConfiguration:DynamicTerminals:NarrativeAdjustments:NarrativeAdjustmentsActivatorScript akSender, var[] kArgs)
    If(kArgs[0] as Form == Self)
        MQDelayTerminal = Game.GetPlayer().PlaceAtMe(RAS_NA_MQDelayTerminal)
        (RAS_NewGameManagerQuest as RAS:NewGameManagerQuest:NewGameManagerQuestScript).MQDelayTerminalAlias.ForceRefTo(MQDelayTerminal)
        MQDelayTerminal.Activate(Game.GetPlayer())
    Endif
EndEvent