Scriptname RAS:UpdateQuest:UpdateQuestScript extends Quest

GlobalVariable Property RAS_ModVersion Mandatory Const Auto
GlobalVariable Property MQ204_TurnOffCF01Arrest Mandatory Const Auto
Quest Property RAS_ShipManagerQuest Mandatory Const Auto

Float LastVersion = 1.03

Event OnQuestInit()
    Update()
EndEvent

Function Update()
    If(RAS_ModVersion.GetValue() < 1.03)
        If((RAS_ShipManagerQuest as RAS:ShipManagerQuest:ShipManagerQuestScript).PedestrianStart)
            MQ204_TurnOffCF01Arrest.SetValueInt(1)
        EndIf
    EndIf
    RAS_ModVersion.SetValue(LastVersion)
EndFunction

