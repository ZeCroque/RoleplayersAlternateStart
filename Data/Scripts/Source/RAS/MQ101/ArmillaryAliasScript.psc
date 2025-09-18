Scriptname RAS:MQ101:ArmillaryAliasScript extends ReferenceAlias

Event OnLoad()
    (GetReference() as ArmillaryScript).PlayAnimation("AlphaStart")
EndEvent