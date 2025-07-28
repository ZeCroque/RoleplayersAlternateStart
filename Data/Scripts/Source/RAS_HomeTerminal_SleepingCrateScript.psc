Scriptname RAS_HomeTerminal_SleepingCrateScript extends Form Const

ObjectReference Property RAS_HomeChoosingTerminal Mandatory Const Auto
Quest Property DialogueFCNeon Mandatory Const Auto

Event OnInit()
    RegisterForCustomEvent(RAS_HomeChoosingTerminal as RAS_HomeChoosingTerminalScript, "HomeChosen")
EndEvent

Event RAS_HomeChoosingTerminalScript.HomeChosen(RAS_HomeChoosingTerminalScript akSender, var[] kArgs)
    If(kArgs[0] as Form == Self)
        DialogueFCNeon.SetStage(620)
    Endif
EndEvent