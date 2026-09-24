Scriptname RAS:EmbeddedModSupport:rbtGear:UnpackEffectScript extends ActiveMagicEffect

Event OnEffectStart(ObjectReference akTarget, Actor akCaster, MagicEffect akBaseEffect, float afMagnitude, float afDuration)
    (Game.GetFormFromFile(0xF0D, "rbt_gear.esm") as GEAR:Main).UseItem()
EndEvent