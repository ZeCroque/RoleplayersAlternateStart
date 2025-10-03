Scriptname RAS:NewGameConfiguration:DynamicTerminals:HomeChoosing:HomeChoosingActivatorScript extends ObjectReference

ObjectReference Property RAS_HomeChoosingTerminalREF Mandatory Const Auto

Event OnCellLoad()
    PlayAnimation("Deploy")
EndEvent

Event OnActivate(ObjectReference akActionRef)
    (RAS_HomeChoosingTerminalREF as RAS:NewGameConfiguration:DynamicTerminals:Base:DynamicEntriesTerminalScript).Activate(Game.GetPlayer())
EndEvent