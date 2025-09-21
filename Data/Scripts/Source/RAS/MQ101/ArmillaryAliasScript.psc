Scriptname RAS:MQ101:ArmillaryAliasScript extends ReferenceAlias

Bool DoOnce = False

Event OnLoad()
    If(!DoOnce)
        (GetReference() as ArmillaryScript).PlayAnimation("AlphaStart")
        DoOnce = true
    EndIf
EndEvent