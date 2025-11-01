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

- **Skip the Vectera Intro**: Begin your journey without the miner prologue. Start the main quest simply by finding the artifact out in the world (configurable). All references to Vectera in main quest dialogue have been removed. Some lines were edited or spliced, while others were created with generative AI.
- **Immersive Beginning**: The custom start configuration takes place in a carefully crafted starting cell, based on the Unity end-game area, designed to feel natural and fully part of the game world.
- **Dynamic Integration**: Automatically detects and includes mod-added locations, ships, and items in the starting options — no patches required.
- **Fully compatible with anything**: No vanilla quests are changed — the mod relies on hooks and replacers. Vanilla starts remain fully playable, including any modifications from other mods.
- **Framework for Modders**: Built from the ground up to be easily extended by other mod authors (documentation will come later on). Also fully open-source — see *LICENSING/LEGAL* for more info.

## 2. DETAILS

### Main Quest Edits

Enjoy the main quest from a different perspective that doesn't force you to roleplay as the miner BGS wanted you to be.

Here's a detailed summary of what have been changed:
1. You will find the first artifact randomly after level 5 upon reaching an eligible location with 33% chance (configurable).
2. Once the artifact is acquired, you will dispose of it in your own way and eventually Constellation will reach out to you.
3. Barrett will leave to assist the Vectera Mining Operation before your arrival at the Lodge, but it has nothing to do with the finding of an artifact. He simply got them into trouble with pirates during another mining operation (during which he found one of the two artifacts Constellation yet has).
4. After entering the Lodge, you will proceed through the standard Constellation intro with all references to you being a miner removed 
5. After Sarah's first quest, you will be tasked with rescuing Barrett on Vectera, again with no prior miner references.
6. Completing Barrett's rescue unlocks the Frontier via a brief follow-up quest.
7. In the standard NG+ start, all references to you being a miner have also been removed.

### Starting Options

Choose from a variety of starting scenarios:
- **At a major Settlement or Starstation (except quest-locked ones, like Crucible or Dazra)**
- **At a Random POI (outpost, mine or dungeon)**: with custom criteria to choose what kind of planet it will be on
- **Shipwrecked**: crash-land in the middle of nowhere and call for help using a rescue beacon (the beacon can also be used during normal gameplay!)
- **In your House/Dream Home/Parent's Home**

### Starting home

Start with any vanilla home already unlocked (except quest tied ones, like the Mercury Tower Penthouse) or even inside some mod-added ones. Currently most of [DownfallNemesis' house mods](https://next.nexusmods.com/profile/DownfallNemesis/mods) are supported (see *COMPATIBILITY* section for a detailed list).

### Narrative Adjustments

Fine-tune how your story unfolds by adding some modifiers to existing quests or applying some immersive constraints to your character: 
- **Delay the Main Quest Start**: choose at which level and under which odds the artifact will spawn — or completely disable the Main Quest 
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

## 3. FREQUENTLY ASKED QUESTIONS

#### Will it come to Creations?
Yes, I'm currently ensuring the mod is stable, I'll release afterward.

#### The mod won't start with my NG+ save, is it normal?
Infortunately, yes. Currently only fresh start are supported. NG+ suppport will come soon™

#### Is there a way to trigger the MQ by going to Vectera?
No, not yet 😕

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

And one optional :
- *RAS_ItemsThroughUnityPatch.esm* (small master)

## 6. INSTALLATION

**Automatic (Recommended)**
- Use the Mod Manager Download button. Install and enable the file(s) in your favorite mod manager (ModOrganizer2 is my personal preference).

**Manual**
- Extract the required files (cf. `2. MOD CONTENT`) from the archive to your Data folder and activate them in the in-game Creations menu

**Note:**
On existing saves, the mod will de-activate itself and shouldn't cause any issues.

## 7. COMPATIBILITY

- Other alternate start mods (either free or paid) are obviously incompatible
- [Unity Framework by DJLegends](https://www.nexusmods.com/starfield/mods/12567) currently incompatible (patch planned)
- [Revelation - Main Quest Overhaul](https://www.nexusmods.com/starfield/mods/10418): compatible
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

You CANNOT, by any mean, upload this mod as a Creation accessible through the in-game menu. I plan to do it myself, but I prefer to wait for community feedback before doing so.

You can find the source code here : https://github.com/ZeCroque/RoleplayersAlternateStart

## 13. FEEDBACK

*Found a bug or have an idea for new features? Let me know in the comment section!*

**Planned features:**
- Optional file to remove as much reference as possible of the player being a miner in any dialog. Known references:
    - Yumi at UC Vanguard office, about troubles we had with pirates
    - During the SysDef scene upon player arrest, about being a miner
    - SSNN, about our involvement on Vectera
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