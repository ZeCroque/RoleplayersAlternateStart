Scriptname RAS:MQ104B:VecteraComputerScript extends ReferenceAlias

Message Property MQ104BSensorArrayMSG_01_Main Mandatory Const Auto
Message Property MQ104BSensorArrayMSG_02_ReplacePowerFail Mandatory Const Auto
Message Property MQ104BSensorArrayMSG_03_OutpostSuccess Mandatory Const Auto
Message Property MQ104BSensorArrayMSG_04_InfoSuccess Mandatory Const Auto

Event OnActivate(ObjectReference akActionRef)
    If akActionRef == Game.GetPlayer()
        Quest MQ104B = GetOwningQuest()
        Int iButtonPressed
        iButtonPressed = MQ104BSensorArrayMSG_01_Main.Show()
        If iButtonPressed == 1
            MQ104BSensorArrayMSG_02_ReplacePowerFail.Show()
            MQ104B.SetStage(45)
        ElseIf iButtonPressed == 2
            MQ104BSensorArrayMSG_03_OutpostSuccess.Show()
            MQ104B.SetStage(50)
        ElseIf iButtonPressed == 3
            MQ104BSensorArrayMSG_04_InfoSuccess.Show()
            MQ104B.SetStage(55)
        EndIf
    EndIf
EndEvent