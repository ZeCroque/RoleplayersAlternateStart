# Roleplayers' Alternate Start

## Index:

1. Overview
2. Details
3. Frequently Asked Questions
4. Known Issues
5. Mod content
6. Installation
7. Compatibility
8. My other mods
9. Recommended Mods
10. Credits
11. Tools used
12. Licensing/Legal 
13. Feedback

## 1. OVERVIEW

*Tired of always starting your journey as a miner on Vectera? NG+ doesn't suit you? Roleplayers' Alternate Start is what you've been waiting for!*

Inspired by classic mods like [Start Me Up (Fallout 4)](https://www.nexusmods.com/fallout4/mods/56984) and [Alternate Start – Live Another Life (Skyrim)](https://www.nexusmods.com/skyrimspecialedition/mods/272), this mod provides a fully dynamic alternate beginning framework designed for roleplayers, modders, and explorers alike.

### Features

- **Skip the Vectera Intro**: Begin your journey without the miner prologue. Start the main quest simply by finding the artifact out in the world (configurable). All references to Vectera in main quest dialogue have been removed. Some lines were edited or spliced, while others were created with generative AI (except for Creations version).
- **Immersive Beginning**: The custom start configuration takes place in a carefully crafted starting cell, based on the Unity end-game area, designed to feel natural and fully part of the game world.
- **Dynamic Integration**: Automatically detects and includes mod-added locations, ships, and items in the starting options — no patches required.
- **Fully compatible with anything**: No vanilla quests are changed — the mod relies on hooks and replacers. Vanilla starts remain fully playable, including any modifications from other mods.
- **Framework for Modders**: Built from the ground up to be easily extended by other mod authors (documentation will come later on). Also fully open-source — see *LICENSING/LEGAL* for more info.

## 2. DETAILS

### Main Quest Edits

Enjoy the main quest from a different perspective that doesn't force you to roleplay as the miner BGS wanted you to be.

There's now two ways of starting the main quest:
- Going to the Argos Extractor Office in the Valberg Building (Commercial District of New Atlantis): if you accept the job you'll start the vanilla intro sequence.
- Finding the Artifact Eta (the one normally found of Vectera) randomly while exploring: it will start an alternate starting sequence that skips the Vectera events.
    - By default there's a 33% chance the artifact will spawn after level 5 upon reaching an eligible location. You can configure these conditions using the "Narrative Adjustments" terminal inside the starting cell. You can find the list of eligible locations in the FAQ section.
    - Once the artifact is acquired, you will dispose of it in your own way and eventually Constellation will reach out to you.
    - Barrett will leave to assist the Vectera Mining Operation before your arrival at the Lodge. During his recovery of Constellation's second artifact he attracted pirate attention, and the Argos miners have evidence that hostile activity is present in the area.
    - After entering the Lodge, you will proceed through the standard Constellation intro with all references to you being a miner removed 
    - After Sarah's first quest, you will be tasked with rescuing Barrett on Vectera, again with no prior miner references.
    - Completing Barrett's rescue unlocks the Frontier via a brief follow-up quest.
    - The vanilla "One Small Step" quest will be entirely skipped when doing this alternate entry point in the MQ, so it will prevent events depending on it to occur, such as the SSNN interview about the Vectera events. You might want that quest to be completed for mod compatibility however: you can do it with the "Narrative Adjustments" terminal.

Those two options are obviously mutually exclusive.

### Starting Options

Choose from a variety of starting scenarios:
- **At a major Settlement or Starstation (except quest-locked ones, like Crucible or Dazra)**
- **At a Random POI (outpost, mine or dungeon)**: with custom criteria to choose what kind of planet it will be on
- **Shipwrecked**: crash-land in the middle of nowhere and call for help using a rescue beacon (the beacon can also be used during normal gameplay!)
- **In your House/Dream Home/Parent's Home**

### Starting home

Start with any vanilla home already unlocked (except quest tied ones, like the Mercury Tower Penthouse) or even inside some mod-added ones. Currently most of [DownfallNemesis' house mods](https://next.nexusmods.com/profile/DownfallNemesis/mods) are supported (see *COMPATIBILITY* section for a detailed list).

### Narrative Adjustments

Fine-tune how your story unfolds by adding some modifiers to existing quests or applying some immersive constraints to your character. You can notably: 
- **Customize Main Quest Starting Conditions**: choose at which level and under which odds the artifact will spawn — or completely disable the Main Quest 
- **Start with a Broken Ship**: your ship will be unable to take off at start and you will have to gather basics materials to repair it

### Ship Options

Pick any vanilla ship as your starting one at a custom ship technician (or even a mod-added one if you have the [Ship Vendor Framework](https://www.nexusmods.com/starfield/mods/10057) installed). You can also customize it or unlock vehicles, all free of charge.

If you don't, you will start as a pedestrian and will need to acquire a ship later on to explore space.

### Gear Options

Build a custom starting loadout using a vending terminal that dynamically offers anything present in the leveled lists, including items added by other mods. 

Set a budget to limit your starting gear for a more immersive experience, or use the free shopping option to assemble your perfect loadout.

### Leveling Options

Skip the early-game grind and jump straight into the higher-level loops if you wish.

The ships sold by the custom technician and the gear available at the vending terminal will update automatically. 

### NG+ Starts

After going through the Unity, you will be prompted if you want to go through the Vanilla NG+ process or if you want to customize this new beginning.
- The vanilla option will take into account whether or not you were an Argos miner in the previous universe and will adapt the Lodge intro scene accordingly
- The custom option comes with extra "Narrative Adjustments":
    - **Argos Miner**: choose to start as if you were a miner in the previous universe, even if you did the alternate MQ start (and vice-versa)
    - **Non-Starborn NG+**: choose to remove all the starborn references & logic and play as if you never reached the Unity (it will still increase the Unity count for the next universe)

Regardless of your choices at the Narrative Adjustments terminal, you can keep the Starborn Guardian or exchange it for any other ship, including the pedestrian one. You're also free to sell the Starborn Suit to the gear terminal if you don't want it.

## 3. FREQUENTLY ASKED QUESTIONS

#### In which POI can the artifact added by the mod spawn?
Here's a list:
- [Abandoned Mineral Refinery](https://starfieldwiki.net/wiki/Starfield:Abandoned_Mineral_Refinery)
- [NeuraDyne Botany Laboratory](https://starfieldwiki.net/wiki/Starfield:NeuraDyne_Botany_Laboratory)
- [Abandoned Muybridge Pharmaceuticals Lab](https://starfieldwiki.net/wiki/Starfield:Abandoned_Muybridge_Pharmaceuticals_Lab)
- [Forgotten Mech Graveyard](https://starfieldwiki.net/wiki/Starfield:Forgotten_Mech_Graveyard)
- [Deserted Robotics Lab](https://starfield.fandom.com/wiki/Deserted_Robotics_Lab)
- [Abandoned Cryo Lab](https://starfieldwiki.net/wiki/Starfield:Abandoned_Cryo_Lab)
- [Abandoned Maintenance Bay](https://starfieldwiki.net/wiki/Starfield:Abandoned_Maintenance_Bay)
- [Pressurized Cave](https://starfieldwiki.net/wiki/Starfield:Pressurized_Cave)
- [Occupied Cave](https://starfieldwiki.net/wiki/Starfield:Occupied_Cave)
- [Deserted UC Listening Post](https://starfieldwiki.net/wiki/Starfield:Deserted_UC_Listening_Post)
- [Abandoned Mine](https://starfieldwiki.net/wiki/Starfield:Abandoned_Mine)
- [Thermal Rise](https://starfieldwiki.net/wiki/Starfield:Thermal_Rise)
- [Hillside Cave](https://starfieldwiki.net/wiki/Starfield:Hillside_Cave)
- [Mineral Caverns](https://starfieldwiki.net/wiki/Starfield:Mineral_Caverns)
- [Cave](https://starfieldwiki.net/wiki/Starfield:Cave) (only in the "OEAF008" layout)

#### Does it support vanilla traits ?
Yes, indeed. There's a few things to note however :
- While I made it so you can visit your parents from game start, they will only have dialogs after you join Constellation
- The adoring fan will only show up after you complete the "Echoes From Vectera" quest, otherwise his dialogs wouldn't have made any sense (thanks to  TwoArmedMan15 for suggesting that)
- The dream home quest will trigger at the start of the game (you need to complete "One Small Step" in vanilla)

#### I found a mention to Constellation/Vectera in the dialogs with that NPC, can you fix it?
Yes, that's in my plans. Currently the mod only covers the first steps of MQ. All other quests/dialogs are left untouched, I'll add them later in an optional file (to ensure maximum compatibility with the base mod). Please check in the *Feedback* section if you find that dialog already listed before requesting.

## 4. KNOWN ISSUES

- The ship called by the rescue beacon may clip into rocks or float slightly after landing. This is a current engine limitation; I will update if a solution is found.
- No voice lines for the dialogs added to Maurice Lyon and the ship technicians.

Please let me know if you find something else.

## 5. MOD CONTENT

This mod consists of two main files : 
- *RoleplayersAlternateStart.esm* (mid master)
- *RoleplayersAlternateStart - Main.ba2*

And two optionals :
- *RAS_ItemsThroughUnityPatch.esm* (small master)
- *RAS_POIVariationsPatch.esm* (small master)

## 6. INSTALLATION

**Automatic (Recommended)**
- Use the Mod Manager Download button. Install and enable the file(s) in your favorite mod manager (ModOrganizer2 is my personal preference).

**Manual**
- Extract the required files (cf. `2. MOD CONTENT`) from the archive to your Data folder and activate them in the in-game Creations menu

**Note:**
On existing saves, the mod will de-activate itself and shouldn't cause any issues.

## 7. COMPATIBILITY

- Other alternate start mods (either free or paid) are obviously incompatible
- [Unity Framework by DJLegends](https://www.nexusmods.com/starfield/mods/12567): compatible
- [Revelation - Main Quest Overhaul by Gothos25](https://www.nexusmods.com/starfield/mods/10418): compatible
- [Choose Your Variant Universe by Aurelianis](https://www.nexusmods.com/starfield/mods/9273): compatible
- [Ship Vendor Framework by rux616](https://www.nexusmods.com/starfield/mods/10057) : support embedded in the main file. You can choose any ship added to the framework as a starting ship.
- Most of DownfallNemesis' house mods have embedded support in the main file (I didn't port the quest-locked ones) :
    - [Earth Dome Home](https://www.nexusmods.com/starfield/mods/13770)
    - [Neon Core Apartment](https://www.nexusmods.com/starfield/mods/13950)
    - [Neon - The Volii Hotel - Room 42](https://www.nexusmods.com/starfield/mods/10449)
    - [New Homestead House](https://www.nexusmods.com/starfield/mods/10519)
    - [Paradiso Cabin](https://www.nexusmods.com/starfield/mods/9881)
    - [Small Akila Player Home](https://www.nexusmods.com/starfield/mods/11444)
    - [Trait Starter Homes](https://www.nexusmods.com/starfield/mods/13929)
- [Take Items Through Unity - No Console Commands by Wartortle](https://www.nexusmods.com/starfield/mods/7309) : compatibility patch included. Re-install my mod if you're adding this one part way.
- [POI Variations - No More Duplicates by PlatinumPoster](https://www.nexusmods.com/starfield/mods/10825) : compatibility patch included. Re-install my mod if you're adding this one part way.

## 8. MY OTHER MODS

- [Astra Economy - Legendary Trading and Rerolling](https://www.nexusmods.com/starfield/mods/11256) : Simple mod to exchange legendary equipments for Astras or reroll your existing legendary gear by talking with Stache from the Trackers Alliance's HQ

## 9. RECOMMENDED MODS

- [Not Yet Shattered Space by paulbrock](https://www.nexusmods.com/starfield/mods/14112)
- [The Trackers Alliance Delayed Start by strangeWindmill](https://www.nexusmods.com/starfield/mods/11533)
- [Nova Transit System by LySoftDev (Creations)](https://creations.bethesda.net/fr/starfield/details/78c9469f-7b64-42e6-a62c-d0a33cad067c/Nova_Transit_System) — Especially useful for pedestrian starts
- DownfallNemesis' house mods

## 10. CREDITS

- Thanks to Bethesda Softworks for this great game
- Thanks to the authors of the tools listed below
- Thanks to SKK for the mod [Fast Start New Game](https://www.nexusmods.com/starfield/mods/5971) which have been a good scripting resource to make my own hooks to MQ
- Thanks to wskeever for the mod [Summoning of Ship - Ship Remote Control](https://www.nexusmods.com/starfield/mods/6216) and especially the ship landing navmesh logic that I use for the rescue beacon
- Thanks to Wynterhawk for the Creation [Roll Your Own Start](https://creations.bethesda.net/en/starfield/details/c27a121a-c565-4ae0-9394-c58952c98f86/Wynter__39_s_Roll_Your_Own_Start) which learnt me a proper way to edit the new game logic that have been crucial for the 1.1.0 update.
- Thanks to xtcrefugee for answering my questions about mid/small masters on the Starfield Modding Discord
- Thanks to Redzy7 for his post on Starfield's design style for the thumbnail (https://www.reddit.com/r/Starfield/comments/15row6b/im_in_love_the_starfield_design_style_so_here_are/)
- Thanks to the Starfield's fonts authors

## 11. TOOLS USED

- Creation Kit
- SF1Edit
- Starfield Plugin Bridge
- Visual Studio Code
- WWise
- WWise Audio Unpacker
- Audacity
- xVaSynth
- FOMOD Creation Tool
- Bethesda Archive Extractor
- Champollion
- Gimp
- ChatGPT as a help for naming things, writing quests logs, this mod page, etc...

## 12. LICENSING/LEGAL 

If you want to modify and/or redistribute this mod, I would like to be contacted first please. Note that it is under GPL3 licensing, thus you have the obligation to make any modification done to the original source code available somewhere publicly.

You can find the source code here : https://github.com/ZeCroque/RoleplayersAlternateStart

## 13. FEEDBACK

*Found a bug or have an idea for new features? Let me know in NexusMods' comment section or on my [Discord server](https://discord.gg/K9Jk4y2tjJ)!*

**Planned features:**
- Optional file to remove as much reference as possible of the player being a miner in any dialog. Known references:
    - Yumi at UC Vanguard office, about troubles we had with pirates
    - During the SysDef scene upon player arrest, about being a miner
    - Player's parents, about the job at Argos
    - Lin says "Dusty" during her recruitment dialog
    - Sarah mentions Vectera in her companion dialogs
    - Vladimir mention Constellation if you contact the Eye
    - Mrs. Whimore random encounter has a constellation dialog option
    - Simeon Bankowski (potential crewmate) has a constellation dialog option
    - Let me now !
- AI-generated voices for Maurice Lyon and the ship technicians
- Prevent Neshar arrest & add another way to start the "Loose Ends" questline
- Faction starts
- Random start
- Improve the "Shipwrecked" quest
- More criterias for random planet selection
- Terminal/Message box customization
- Outpost menu icon for the rescue beacon
- Bypass skill challenges during character creation (SFSE)
- French translation
- You tell me!