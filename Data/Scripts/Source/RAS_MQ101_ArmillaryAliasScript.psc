Scriptname RAS_MQ101_ArmillaryAliasScript extends ReferenceAlias

Event OnLoad()
    (GetReference() as ArmillaryScript).PlayAnimation("AlphaStart")
EndEvent