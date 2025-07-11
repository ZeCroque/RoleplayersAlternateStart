Scriptname RAS_MQ101SetStage1510TriggerScript extends ReferenceAlias

Quest Property MQ102 Mandatory Const Auto
ObjectReference Property VascoREF Auto Const Mandatory
Quest Property FFLodge01 Mandatory Const Auto
Perk Property Crew_Ship_AneutronicFusion Mandatory Const Auto
Perk Property Crew_Ship_Shields Mandatory Const Auto
Perk Property Crew_Ship_Weapons_EM Mandatory Const Auto
Faction Property ConstellationFaction Mandatory Const Auto
Faction Property PotentialCrewFaction Mandatory Const Auto
Key Property LodgeKey Auto Const Mandatory

Event OnTriggerEnter(ObjectReference akActionRef)
    MQ102.SetObjectiveDisplayed(10, true, true)
    FFLodge01.SetObjectiveDisplayed(10, true, true)
    
    Actor PlayerREF = Game.GetPlayer()
    PlayerREF.AddToFaction(ConstellationFaction)
    PlayerREF.AddItem(LodgeKey)

    Actor Vasco = VascoREF as Actor
    Vasco.SetFactionRank(PotentialCrewFaction, 1)
    Vasco.AddPerk(Crew_Ship_AneutronicFusion)
    Vasco.AddPerk(Crew_Ship_Shields)
    Vasco.AddPerk(Crew_Ship_Shields)
    Vasco.AddPerk(Crew_Ship_Weapons_EM)
EndEvent