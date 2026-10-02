# WILDROOT — GAME DESIGN & DEVELOPMENT SOURCE OF TRUTH

> **Catatan rencana kerja, 2026-09-30:** Setelah review desain dan permintaan pemilik
> untuk modul belajar/agenda kerja, pelaksanaan awal mengikuti `ROADMAP.md`.
> Bagian 36, 38, 39, 52, dan 55 di bawah tetap menyimpan usulan lingkup dan urutan
> awal; seluruh isinya tidak menjadi tugas yang harus dibangun sekaligus.
> Target terdekat adalah petak hutan + interaksi berry, kemudian hari dan hubungan
> wolf/rabbit/berry. Bukti dari percobaan menentukan perluasan berikutnya.
> Aturan sementara bukan balance final atau hasil playtest. Alasan dan pertanyaan
> terbuka ada di `DESIGN_REVIEW.md`; identitas ecology-first tetap berlaku.

> **Status:** Working design specification  
> **Purpose:** Primary design context for Codex / AI coding assistance and human development  
> **Engine:** Godot  
> **Art pipeline:** Aseprite + pixel-art workflow  
> **Target platform:** PC first  
> **Working title:** Wildroot

---

## 0. How to Use This File

This file is the current source of truth for the Wildroot project.

When implementing features:

1. Preserve the **ecology-first identity**.
2. Prefer small, reusable, data-driven systems over giant scripts.
3. Do not add features only because other farming games have them.
4. Do not build future systems before the current prototype proves the core loop is fun.
5. Prefer compact handcrafted maps over large procedural worlds.
6. Farming, combat, crafting, creatures, seasons, bosses, and exploration must reinforce the same ecological loop.
7. If implementation requires deviating from this document, explicitly document the deviation.
8. Design for a solo / very small-team production scope.

---

# 1. High-Level Vision

## 1.1 Elevator Pitch

**Wildroot is a compact top-down pixel action RPG about learning how a fantasy ecosystem works, then deliberately shaping it through farming, hunting, habitat management, observation, crafting, and combat to unlock resources, equipment, world states, new regions, and bosses.**

The core fantasy is:

> **Understand the world, then shape it.**

Knowledge is a form of progression.

---

## 1.2 Genre

Primary:
- Action RPG
- Life / farming simulation
- Ecological simulation
- Exploration
- Light crafting

Secondary influences:
- Rune Factory
- Harvest Moon / Story of Seasons
- Stardew Valley
- Kynseed
- Don't Starve
- Moonlighter
- Secrets of Grindea
- Monster Hunter

These are references, not templates to copy.

---

## 1.3 Core Identity — Ecological Causality

The world reacts to player action.

Examples:

- Hunting too many wolves causes rabbits to increase.
- Too many rabbits reduce vegetation.
- Reduced vegetation may increase fungal opportunity.
- Fungal spread can trigger an ecological anomaly.
- Certain ecological states can produce rare materials.
- Some bosses can appear because the player deliberately or accidentally caused a particular world state.

There is no universal:

- "healthy ecology = correct",
- "disturbed ecology = wrong".

Different states create different:
- rewards,
- risks,
- resources,
- encounters,
- visual states.

---

# 2. Design Pillars

## 2.1 Ecology Is the Main System

Every major feature should ideally:
- change ecology,
- react to ecology,
- reveal ecology,
- or reward ecological understanding.

## 2.2 Small World, High State Variation

Prefer a compact memorable world with changing states over a huge map.

Possible forest states:
- Healthy Forest
- Overgrazed Forest
- Predator-Dominant Forest
- Fungal Outbreak
- Magical Bloom
- Seasonal State
- Post-Storm State

## 2.3 Knowledge Is Progression

Progression includes:
- level and gear,
- ecological observations,
- diets,
- habitats,
- migration patterns,
- predator-prey relationships,
- symbiosis,
- rare-material conditions,
- hidden boss conditions.

## 2.4 Combat Is an Intervention Tool

Combat is used for:
- exploration,
- hunting,
- defense,
- resource collection,
- territorial creatures,
- controlling populations,
- ruins,
- bosses.

Killing should not always be the optimal solution.

## 2.5 Farming Is Ecological Engineering

Farming is not only:

`seed -> water -> harvest`

The farm contains controlled mini-ecosystems.

Examples:
- rice + fish,
- flower + bees,
- orchard + chickens,
- mushroom beds + slime,
- pond + aquatic plants + fish.

## 2.6 Discovery Should Create "Aha!" Moments

Desired player thought:

> "Wait... if this creature does that, maybe I can use it to create this other condition."

Loop:
`OBSERVE -> HYPOTHESIZE -> INTERVENE -> CONSEQUENCE -> DISCOVERY`

---

# 3. Player Journey — Start to Finish

## Opening

The player arrives at or inherits a small farm near a village.

The opening tone is:
- calm,
- curious,
- grounded,
- slightly magical.

Early tutorials:
- movement,
- interaction,
- basic farming,
- day/night rhythm,
- basic combat.

The world is not under an urgent apocalypse timer.

---

## ACT I — LEARN

### First Controlled Ecology Lesson: Rice + Fish

Simple chain:

`Rice -> Pest -> Fish`

The player plants rice.

Pests appear later.

A fisherman or local NPC hints that fish were traditionally allowed to live in rice paddies.

The player experiments.

Fish can:
- eat some pests,
- produce nutrients,
- improve the rice system.

Do not show raw bonus numbers immediately.

Use:
- visual pest reduction,
- rice condition,
- fish activity,
- qualitative journal updates.

### First Wild Ecology Lesson

Forest chain:

`Berry -> Rabbit -> Wolf`

The player may hunt wolves for fangs.

If too many wolves are killed:

`Wolf ↓ -> Rabbit ↑ -> Berry ↓`

The forest visibly changes.

This should create the first major realization:

> **The world remembers what I do.**

---

## ACT II — INTERVENE

Introduce:
- Slime
- decomposition
- fungus
- deeper forest
- crafting
- first ecological anomaly

Example:

`Rotten Organic Matter -> Slime -> Fertility -> Mushroom`

If the player kills slimes:
- gets slime gel now,
- but decomposition is reduced,
- some fungi become rarer.

If slimes are preserved:
- fertility may increase,
- fungus can spread.

The player starts choosing between:
- immediate loot,
- long-term ecological opportunity.

---

## ACT III — ENGINEER

The player now intentionally creates ecological conditions.

Examples:
- increase pollinators,
- restore or reduce predators,
- prepare fungal soil,
- modify water habitats,
- preserve migration routes,
- grow ecological infrastructure on the farm.

Important philosophy:

> Wildroot is not about "never disturbing nature."

Different states are useful for different goals.

A highly fungal forest may be dangerous but may produce rare fungal resources.

A predator-heavy forest may reduce herbivores but create rare predator materials.

---

## ACT IV — ADAPT

Introduce full seasonal ecology.

### Spring
- rain ↑
- flowers ↑
- insects ↑
- reproduction ↑

### Summer
- water ↓
- drought risk ↑
- fire ecology ↑
- animals concentrate near water

### Autumn
- fruit ↑
- migration ↑
- foraging ↑

### Winter
- plant growth ↓
- food scarcity ↑
- predator pressure changes
- frozen paths may open

Example:

A rice-fish setup that works in spring may struggle in summer.

Possible adaptations:
- deeper fish refuge,
- change fish species,
- redirect water,
- change temporary crop.

---

## ACT V — MASTERY

Late-game chains are longer.

Example:

`Thunder Deer -> Storm Vegetation -> Storm Beetle -> Wind Drake`

The player can intentionally:
- create,
- suppress,
- or exploit

rare world states.

Late-game difficulty should test:
- ecology knowledge,
- preparation,
- observation,
- combat,
- world manipulation.

Avoid simply multiplying enemy HP.

---

# 4. Story Direction

The region is connected by a mysterious ecological / magical network:

## The Root

The Root resembles a combination of:
- mycelium,
- roots,
- magical memory,
- ecological network.

Most people treat it as:
- folklore,
- religion,
- forgotten science,
- superstition.

The player gradually discovers that:
- forests,
- rivers,
- mountains,
- creatures,
- seasonal phenomena,
- ancient ruins

are all connected through The Root.

An ancient civilization previously attempted to control The Root completely.

They failed because they attempted to make nature perfectly predictable.

Theme:

> **Nature is not a puzzle with one correct final state.**

---

# 5. Final Region

## Ancient Root / Root Depths

The final region combines previously learned systems:
- aquatic organisms,
- forest plants,
- fungi,
- mineral creatures,
- seasonal energy,
- magical species.

The final area is an ecological "exam".

It should test:
- knowledge,
- preparation,
- observation,
- combat,
- manipulation.

---

# 6. Final Boss

Working concept:

## The Rootbound Guardian

The boss reacts to the player's overall world state.

Examples:

### Predator-heavy world
Possible boss changes:
- aggressive movement,
- hunting attacks,
- pack-like summons.

### Fungus-heavy world
Possible boss changes:
- spores,
- infection zones,
- fungal summons.

### Aquatic-heavy world
Possible arena changes:
- water zones,
- aquatic hazards,
- movement changes.

Do not create dozens of final bosses.

Use one strong boss framework with meaningful ecological variants.

Desired emotional result:

> "This boss reflects the world I shaped."

---

# 7. Ending

Avoid:
- Good Ending
- Bad Ending

Use an:

## Ecological Ending Profile

Show the resulting state of:
- Farm
- Forest
- River
- Mountain
- Village
- Major species

Possible character of the world:
- highly cultivated,
- highly biodiverse,
- predator-dominant,
- magical fungal,
- aquatic-focused,
- heavily engineered,
- mostly wild.

Do not rank these morally.

Allow post-game continuation.

---

# 8. Post-Game

Possible goals:
- complete Research Journal,
- discover hidden interactions,
- trigger rare anomalies,
- hunt seasonal creatures,
- craft ultimate equipment,
- optimize farm ecosystems,
- discover Root creatures,
- complete rare recipes.

NG+ is optional, not required for 1.0.

---

# 9. Core Gameplay Loop

Detailed loop:

1. Wake / prepare.
2. Inspect farm.
3. Observe farm ecological conditions.
4. Harvest / feed / plant / modify habitat.
5. Talk to NPCs and gather clues.
6. Enter a biome.
7. Observe creatures and environment.
8. Fight / hunt / avoid / intervene.
9. Gather resources.
10. Discover ecological information.
11. Return home.
12. Craft / upgrade / reorganize farm.
13. Sleep.
14. Daily ecology simulation updates.
15. World state changes.
16. Repeat with new information.

Condensed:

`OBSERVE -> HYPOTHESIZE -> INTERVENE -> WORLD CHANGES -> RESOURCE / EVENT -> CRAFT / UPGRADE -> EXPLORE DEEPER -> OBSERVE`

---

# 10. Wild Ecology System

Each biome owns abstract ecology state.

Example:

```text
ForestState
- rabbit_population
- wolf_population
- berry_density
- slime_population
- soil_fertility
- fungus_level
- water_quality
- disturbance
```

Do NOT simulate every creature physically at all times.

Possible daily logic:

```text
rabbit_growth = food_factor - predation - player_hunting
wolf_growth = prey_factor - starvation - player_hunting
berry_change = regrowth - rabbit_consumption
soil_fertility += slime_decomposition
fungus_growth = fertility_factor + moisture_factor
```

Backend can use numbers.

The player should mainly see:
- spawn density,
- environment changes,
- animations,
- NPC comments,
- journal descriptors,
- audio changes.

---

# 11. Abstract Population vs Visible Creatures

Critical architecture rule:

### Ecological population state != number of active creature nodes

Example:

`rabbit_population = 72`

does not mean 72 rabbit nodes exist.

Instead:
- population determines spawn density,
- local spawners instantiate a manageable number,
- visible creatures represent the larger population.

This keeps simulation manageable.

---

# 12. Farm Ecology

Potential farm ecosystems:

## Paddy — Rice + Fish

Benefits:
- pest control,
- nutrient cycling.

Risks:
- overcrowding,
- low water,
- predators.

Possible upgrade:
- deeper fish refuge trench.

## Orchard — Fruit + Chicken

Benefits:
- insect control,
- manure.

Risks:
- soil disturbance,
- root damage.

## Apiary — Flowers + Bees

Benefits:
- pollination,
- honey.

Risks:
- seasonal sensitivity,
- attraction of predators / competitors.

## Mushroom Garden — Waste + Slime + Fungus

Benefits:
- decomposition,
- rare mushrooms.

Risks:
- fungal spread,
- imbalance.

## Pond — Aquatic Plants + Fish

Benefits:
- food,
- fertilizer,
- ecological utility.

Risks:
- water imbalance,
- crowding.

---

# 13. Research Journal

The journal is a major progression system.

Entries begin incomplete.

Example:

```text
FOREST WOLF

Habitat:
✓ Forest

Diet:
✓ Rabbit
? ???

Activity:
✓ Dusk
✓ Night

Ecological Role:
✓ Predator

Interactions:
? ???
```

Discover knowledge through:
- observation,
- NPC clues,
- experiments,
- quests,
- repeated encounters,
- research tools.

Knowledge can unlock:
- recipes,
- crafting methods,
- ecological hints,
- rare-condition clues,
- map information.

The journal must not be only a static Pokédex.

---

# 14. Combat

Combat should be:
- responsive,
- readable,
- approachable,
- not Soulslike-hard.

Target 1.0 weapon families:
1. Sword
2. Spear
3. Axe / Hammer
4. Bow

Core requirements:
- attack animation,
- hitbox,
- hurtbox,
- knockback,
- hit reaction,
- invulnerability frames,
- enemy telegraphing.

Only add more weapons after the core is proven.

---

# 15. Weapon Progression

Weapons are not only linear stat upgrades.

Rare equipment can require ecological conditions.

Example:

## Thunder Spear

Requires:
- Stormwood
- Conductive Ore
- Thunder Antler Fragment

Stormwood condition:

`Thunder Deer Migration -> Lightning Tree -> Storm Strike -> Stormwood`

Knowledge produces gear.

This should be one of the game's strongest reward loops.

---

# 16. Crafting

Crafting connects ecology to player power.

Inputs may come from:
- mining,
- plants,
- hunting,
- ecological events,
- bosses,
- rare world states.

Avoid arbitrary recipes such as:
- 100 identical monster drops.

Prefer fewer, meaningful, memorable materials.

---

# 17. Creature Design

Creatures are not just enemies.

Each species should ideally define:
- habitat,
- diet,
- activity schedule,
- predators,
- prey,
- ecological role,
- response to player,
- resource value,
- fantasy interaction.

## Example — Forest Wolf

Role:
- predator

Diet:
- rabbit
- possibly boar

Behavior:
- patrol,
- stalk,
- hunt,
- rest,
- defend territory.

Player effect:
- hunting wolves changes rabbit population.

## Example — Slime

Role:
- decomposer

Feeds on:
- rotten crops,
- organic matter,
- carcass residue.

Effects:
- decomposition,
- fertility,
- fungus.

## Example — Thunder Deer

Base:
- recognizable deer biology.

Fantasy twist:
- antlers interact with electricity.

Ecology:
- herbivore,
- migratory,
- storm interaction.

Rare condition:

`Thunder Deer + Lightning Tree + Storm -> Stormwood`

---

# 18. Creature Design Rule

Use:

## Real-world ecological logic + one strong fantasy mutation

Examples:
- Deer + lightning
- Koi + moonlight
- Beetle + fire pollination
- Slime + decomposition
- Golem + mineral ecology

The creature should remain intuitive enough that the player can form hypotheses.

Avoid arbitrary fantasy behavior with no systemic logic.

---

# 19. Monster Taming / Companions

Possible but secondary.

Do NOT make Palworld-style workforce automation the game identity.

If companions exist, give them a focused niche.

Examples:
- Wolf tracks rare creatures.
- Fire Slime assists furnace processes.
- Bird detects seeds or migration.
- Golem helps locate ore.

Companions should reinforce ecology or exploration.

---

# 20. Boss Structure

Three main boss categories:

## 20.1 Biome Guardian

Purpose:
- story progression,
- region mastery,
- clear RPG structure.

## 20.2 Seasonal Creature

Purpose:
- optional challenge,
- migration event,
- rare material.

Missed seasonal creatures should return later.

Avoid permanent missable punishment.

## 20.3 Ecological Anomaly

Signature system.

An ecological anomaly appears when ecological conditions reach specific combinations.

Example trigger:

```text
wolf_population: very low
rabbit_population: very high
vegetation: low
fungus_level: high
```

Result:

## Mycelial Outbreak

Possible effects:
- spores,
- infected creatures,
- giant mushrooms,
- altered forest art,
- altered music,
- NPC reactions.

Boss:

## Mycelial King

Reward:
- Mycelial Heart
- rare fungal material

Possible craft:

## Sporeblade

Possible effect:
- defeated enemies may leave damaging spores.

This is the intended ecology -> boss -> crafting loop.

---

# 21. Seasonal System

Season should affect:
- reproduction,
- rainfall,
- water level,
- migration,
- predator behavior,
- plant regeneration,
- insect population,
- rare phenomena,
- traversal.

Possible traversal:
- summer reveals a cave as water drops,
- winter freezes a lake,
- spring floods open a temporary route.

Season is not only a crop calendar.

---

# 22. Day / Time

Basic cycle:
- morning,
- daytime,
- evening,
- night,
- sleep,
- next day.

Ecological updates should happen:
- at day transition,
- controlled scheduled intervals,
- or specific events.

Avoid expensive full-world simulation every frame.

---

# 23. Death / Failure

The game should be forgiving.

Possible death consequences:
- wake at clinic,
- lose some expedition materials,
- lose some money,
- lose part of the day.

Do NOT remove:
- major weapons,
- farm,
- research discoveries,
- story progress.

Players should feel safe experimenting.

---

# 24. Survival Policy

Wildroot is not a hardcore survival game.

Avoid mandatory:
- hunger death,
- sanity death,
- instant night death,
- extreme temperature micromanagement.

Food is better used for:
- healing,
- buffs,
- resistance,
- preparation.

Examples:
- steak -> attack buff,
- mushroom soup -> poison resistance,
- honey toast -> stamina regeneration.

---

# 25. World Layout

Target philosophy:

## Compact, handcrafted, readable.

Possible graph:

```text
                         MOUNTAIN
                    ┌──────┴──────┐
                 ALPINE        ANCIENT RUINS
                    │               │
                 FOREST ─── DEEP FOREST
                    │
       LAKE ───── VILLAGE ───── MARSH
                    │
                   FARM
                    │
                  RIVER
```

Not all regions open immediately.

---

# 26. Target 1.0 Scope

Approximate targets:

| Content | Target |
|---|---:|
| Major regions | 6–8 |
| Core wild biomes | 4 |
| Important NPCs | 12–16 |
| Creature species | 20–28 |
| Crops | 10–14 |
| Fish / aquatic species | 6–10 |
| Weapon families | 4 |
| Major bosses | 5–7 |
| Ecological anomalies | 4–6 |
| Seasons | 4 |
| Main story | 12–18 hours |
| Completionist play | 20–30+ hours |

These are direction targets, not promises.

Do not expand automatically.

---

# 27. NPC / Town Scope

Small memorable village.

Potential roles:
- Farmer
- Fisherman
- Hunter
- Herbalist
- Blacksmith
- Researcher
- Cook
- Merchant
- Carpenter
- story families / characters

NPC purpose:
- clues,
- services,
- recipes,
- ecological context,
- story,
- relationship events.

Romance is not a core pillar for 1.0.

---

# 28. Economy

Important progression resources:

1. Money
2. Materials
3. Knowledge
4. Ecological conditions

Money cannot buy everything.

Rare items should often require world knowledge.

---

# 29. Visual Direction

## Perspective
Top-down / 3/4 RPG.

## Pixel Scale
Current direction:
- world tile around 32x32 px,
- player frame around 48–64 px,
- current character art around 56x56 px is compatible,
- collision footprint smaller than visual sprite.

Example:

```text
Tile: 32x32
Player frame: 56x56
Player collision: approximately 20x14 around the feet
```

Exact values require testing.

## Visual Reference Principles

### Kynseed
- lush nature,
- dense vegetation,
- environmental richness.

### Fields of Mistria
- warm farm / village,
- readable cozy spaces.

### Moonlighter
- combat clarity,
- readable silhouettes.

### Secrets of Grindea
- larger action-RPG sprite feel,
- combat scale.

Use principles, not literal style mixing.

---

# 30. Environment as Ecology UI

The environment should communicate state.

### Healthy Forest
- dense grass,
- flowers,
- insects,
- berries.

### Overgrazed Forest
- short grass,
- bare soil,
- damaged bushes,
- rabbit burrows.

### Fungal Outbreak
- spores,
- mushrooms,
- pale vegetation,
- infected trees,
- carcasses.

Do not rely only on meters.

---

# 31. Audio Direction

### Farm / Village
- warm,
- acoustic,
- calm.

### Forest
- natural ambience,
- organic instruments,
- light percussion.

### Ecological Anomaly
- distorted biome motif,
- strange ambience,
- subtle discomfort.

### Boss
- stronger rhythm,
- retain biome identity.

Audio can also reveal ecology:
- fewer birds when biodiversity falls,
- more insects during bloom,
- distant howls when wolves are abundant,
- electrical ambience during Thunder Deer migration.

---

# 32. Godot Project Architecture

Recommended structure:

```text
res://

  core/
    game_state/
    day_system/
    save_system/
    event_bus/

  data/
    items/
    weapons/
    creatures/
    crops/
    biomes/
    recipes/
    ecology/

  player/
    player.tscn
    player.gd

  combat/
    hitbox/
    hurtbox/
    damage/
    weapons/

  creatures/
    base_creature/
    rabbit/
    wolf/
    slime/

  ecology/
    ecology_manager.gd
    biome_state.gd
    ecology_rules/
    population_model/

  world/
    farm/
    village/
    forest/
    deep_forest/
    river/
    lake/
    marsh/
    mountain/
    ruins/

  farming/
    crop/
    paddy/
    pond/
    farm_plot/

  crafting/
  research/
  ui/

  assets/
    characters/
    creatures/
    tilesets/
    items/
    effects/

  audio/
```

Avoid putting every script into one generic `scripts/` folder.

---

# 33. Data-Driven Resources

Suggested Godot Resources:

```text
ItemData
WeaponData
CreatureData
SpeciesData
CropData
FishData
RecipeData
BiomeData
EcologyInteractionData
BossData
SeasonData
```

Example `SpeciesData` fields:

```text
species_name
base_hp
base_damage
move_speed
aggression
activity_period
diet
predators
prey
ecological_role
preferred_habitat
drops
behavior_profile
research_entries
fantasy_interactions
```

Adding a species should not require rewriting the entire ecology system.

---

# 34. Event Architecture

Useful events:

```text
day_changed
season_changed
creature_killed
creature_observed
population_changed
ecology_threshold_crossed
rare_condition_met
boss_triggered
research_discovered
crop_harvested
craft_completed
```

Avoid tightly coupling:
- UI,
- ecology,
- creatures,
- crafting,
- journal.

---

# 35. Save Data

Persist:
- current day,
- current season,
- player stats,
- inventory,
- equipped gear,
- farm state,
- crop state,
- ecological biome states,
- research discoveries,
- NPC relationship state,
- world events,
- defeated bosses,
- crafting unlocks.

Plan save architecture early.

Do not blindly serialize entire scene trees.

Prefer explicit save data.

---

# 36. First Prototype

## Wildroot Prototype 0.1 — Forest Ecology

Minimum content:

### Player
- movement
- interact
- attack
- HP

### Weapon
- 1 weapon

### Creatures
- Rabbit
- Wolf
- Slime

### Wild Plants
- Berry
- Mushroom

### Maps
- Farm
- Forest
- Deep Forest

### Ecology
- Wolf <-> Rabbit <-> Berry
- Organic Waste <-> Slime <-> Fertility <-> Mushroom

### Farming
- 1 basic crop initially
- rice-fish proof immediately after forest ecology works

### Boss
- 1 ecological anomaly boss

### UI
- HP
- simple inventory
- basic Research Journal

### Save
- 1 save slot

Target raw prototype:
- 20–40 minutes

Target polished vertical slice:
- 30–60 minutes

---

# 37. Prototype Success Criteria

The prototype succeeds if the player can:

1. Observe a relationship.
2. Cause an ecological change.
3. Notice that change without needing exact backend numbers.
4. Form a hypothesis.
5. Intentionally manipulate the ecology.
6. Receive a useful reward because of that manipulation.

Ideal reaction:

> "Ohhh... if I do X, then Y happens. Maybe I can use that to get Z."

Do not scale production until this works.

---

# 38. Development Roadmap

## Phase 0 — Foundation

Build:
- Godot project structure
- player movement
- collision
- camera
- interaction
- animation state
- test map
- basic save architecture

Exit:
- player can move around one stable map.

## Phase 1 — Combat Prototype

Build:
- one weapon
- hitbox
- hurtbox
- damage
- knockback
- i-frames
- enemy death
- loot
- simple creature AI

Exit:
- fighting one creature feels acceptable.

## Phase 2 — Ecology Prototype

Build:
- Rabbit
- Wolf
- Berry
- abstract population model
- daily ecology tick
- population -> visible spawn density
- visual environment state

Exit:
- hunting wolves visibly affects rabbit and berry state.

This is the most important milestone.

## Phase 3 — Farm Ecology

Build:
- rice
- pest
- fish
- simple water state
- rice-fish interaction
- visual condition feedback

Exit:
- player can learn and exploit one controlled ecological relationship.

## Phase 4 — Research & Crafting

Build:
- Research Journal
- ecological discoveries
- inventory
- simple crafting
- first ecology-dependent recipe

Exit:
- knowledge directly helps unlock a useful item.

## Phase 5 — Vertical Slice

Include:
- Farm
- small Village
- Forest
- Deep Forest
- 3–5 creatures
- crafting
- Research Journal
- one ecological anomaly
- one boss
- representative pixel art
- representative music / SFX
- save/load

Target:
- 30–60 polished minutes.

Exit:
- a new player understands the game's identity without a long explanation.

## Phase 6 — Production

Gradually add:
- Marsh
- Lake
- Mountain
- Seasons
- NPC stories
- more creatures
- more weapons
- more ecological states
- story progression
- biome guardians

## Phase 7 — Alpha

Definition:
- playable from New Game to Final Boss.

May still contain:
- placeholder art,
- bugs,
- poor balance.

Do not add new major pillars after this.

## Phase 8 — Beta

Focus:
- balance,
- UX,
- onboarding,
- bugs,
- performance,
- controller support,
- accessibility,
- audio,
- save reliability,
- polish.

## Phase 9 — Release

Prepare:
- PC build
- store page
- trailer
- demo if desired
- achievements if desired
- cloud save if practical
- final QA
- version 1.0

---

# 39. Recommended Initial Task Order

```text
PLAYER-001   8-direction movement
PLAYER-002   collision
PLAYER-003   interaction

WORLD-001    test map
WORLD-002    map transition

COMBAT-001   attack
COMBAT-002   hitbox
COMBAT-003   hurtbox
COMBAT-004   damage / death

CREATURE-001 base creature state machine
CREATURE-002 wolf
CREATURE-003 rabbit

TIME-001     day clock
TIME-002     sleep / next day

ECO-001      biome state
ECO-002      population values
ECO-003      daily ecology tick
ECO-004      population -> spawn density
ECO-005      berry regeneration

CREATURE-004 slime
ECO-006      decomposition
ECO-007      fertility
ECO-008      fungus state

FARM-001     crop plot
FARM-002     rice
FARM-003     pest
FARM-004     fish
FARM-005     rice-fish interaction

UI-001       simple HUD
UI-002       inventory
UI-003       Research Journal

CRAFT-001    recipes
CRAFT-002    first ecology-dependent weapon

BOSS-001     ecological trigger
BOSS-002     Mycelial King prototype

SAVE-001     save/load
```

---

# 40. Do Not Build Too Early

Do not prioritize:

- marriage,
- many romance candidates,
- major festivals,
- deep fishing minigame,
- 50 cooking recipes,
- dozens of crops,
- dozens of weapons,
- deep skill trees,
- pet breeding,
- monster evolution,
- large town,
- procedural roguelike dungeon,
- all four full seasons before ecology works,
- complex weather simulation,
- multiplayer,
- deep character creator,
- housing decoration,
- 40+ NPCs,
- 100 quests.

These are content multipliers.

---

# 41. Procedural Dungeon Policy

Procedural roguelike dungeon is not core for early development.

Reason:

The player must be able to tell whether a change came from:
- ecology,
- or procedural generation.

Handcrafted maps make ecological causality easier to read.

Optional procedural combat spaces may be explored later.

---

# 42. Design Risks

## Risk — Ecology Is Invisible

Problem:
- numbers change but the player does not understand why.

Mitigation:
- environment changes,
- spawn density,
- animations,
- NPC comments,
- journal updates,
- soundscape changes.

## Risk — Ecology Becomes a Spreadsheet

Mitigation:
Backend may use exact numbers, but player-facing information should use qualitative states.

Examples:

### Population
- Scarce
- Uncommon
- Common
- Abundant
- Overpopulated

### Vegetation
- Barren
- Sparse
- Healthy
- Lush

### Water
- Clear
- Murky
- Polluted

### Soil
- Poor
- Healthy
- Rich

### Fungus
- Trace
- Present
- Spreading
- Outbreak

## Risk — Player Is Afraid to Experiment

Mitigation:
- most states are recoverable,
- disturbed states can create useful opportunities,
- avoid permanently destroying a save,
- allow restoration or natural recovery.

## Risk — Combat and Ecology Feel Separate

Mitigation:
- combat affects populations,
- ecology creates materials,
- materials create weapons,
- weapons enable deeper exploration,
- bosses depend on ecological state.

## Risk — Farming Becomes a Separate Stardew Clone

Mitigation:
- farm ecology,
- species interactions,
- ecological infrastructure,
- rare outputs from symbiosis.

## Risk — Simulation Complexity Explodes

Mitigation:
- abstract population model,
- local visible representatives,
- daily / scheduled ticks,
- few important variables per biome.

## Risk — Solo Scope Becomes Too Large

Mitigation:
- compact world,
- fewer but deeper species,
- limited NPC count,
- 4 weapon families for 1.0,
- reusable systemic content.

---

# 43. Non-Goals

Wildroot is NOT primarily:
- hardcore survival,
- roguelike,
- monster collection,
- factory automation,
- huge open world,
- dating simulator,
- pure farming simulator,
- Soulslike,
- MMO,
- scientific ecosystem simulator.

Some elements may overlap, but they are not the identity.

---

# 44. Feature Decision Filter

Before adding a feature, ask:

1. Does it strengthen ecological discovery or manipulation?
2. Does it connect to at least one existing major system?
3. Can the player understand its effect through gameplay?
4. Is it achievable for a solo / small team?
5. Does it create meaningful decisions instead of repetitive chores?

If most answers are "no", it is low priority.

---

# 45. Example Full Gameplay Scenario — Thunder Spear

Goal:
Craft a rare Thunder Spear.

Required:
- Conductive Ore
- Stormwood
- Thunder Antler Fragment

Player discovers:
- Thunder Deer migrate in autumn,
- they pass near Lightning Trees,
- storms are more frequent under certain conditions.

Player actions:
1. Preserve Thunder Deer population.
2. Learn migration route.
3. Preserve or plant Lightning Trees near the route.
4. Wait for migration and storm conditions.
5. Lightning strikes a tree.
6. Stormwood forms.
7. Gather Stormwood.
8. Mine Conductive Ore.
9. Obtain an antler fragment.
10. Craft Thunder Spear.

The player does not simply kill 100 deer.

This is a model Wildroot progression scenario.

---

# 46. Example Farm Scenario — Rice + Fish

Rice develops pests.

### Option A — Direct Pest Control

Fast result:
- pests decrease.

Possible downside:
- beneficial insects decline,
- fish may suffer,
- water quality may change.

### Option B — Ecological Control

Introduce Mud Carp.

Effects:
- fish consume pests,
- fish provide nutrients,
- rice condition improves.

Risks:
- overcrowding,
- drought vulnerability,
- bird predators.

Later upgrade:
- deeper fish refuge.

Farm progression becomes ecological infrastructure, not only numeric upgrades.

---

# 47. Example Ecological Boss Scenario

The player overhunts wolves.

Chain:

```text
Wolf ↓
Rabbit ↑
Berry ↓
Vegetation ↓
Fungal Opportunity ↑
Fungus ↑↑
```

Trigger:

## Mycelial Outbreak

World changes:
- spores,
- infected creatures,
- mushrooms,
- altered music,
- changed NPC dialogue.

Boss:
## Mycelial King

Reward:
- Mycelial Heart.

Craft:
## Sporeblade

This is a complete:

`PLAYER ACTION -> ECOLOGY -> WORLD EVENT -> BOSS -> MATERIAL -> EQUIPMENT`

loop.

---

# 48. Art Production Philosophy

Do not wait for final art.

Prototype with placeholders.

Lush environments can be achieved with reusable details.

Example forest kit:
- grass base,
- grass variations,
- flowers,
- rocks,
- bushes,
- mushrooms,
- branches,
- leaf piles,
- shadows.

One rich small map is better than many empty maps.

---

# 49. Current Character Art Direction

Current character work is compatible with:
- roughly 56x56 px frames,
- top-down / 3/4 presentation,
- around 32x32 world tiles.

Player sprite may be larger than one tile.

Collision is based around the feet, not full sprite bounds.

---

# 50. Audio as Ecological Feedback

Audio should reinforce ecological states.

Examples:
- fewer bird calls when bird populations fall,
- increased insects during bloom,
- more distant howls when wolves are abundant,
- spore ambience during fungal outbreaks,
- electricity during Thunder Deer migration.

Audio is part of world-state readability.

---

# 51. Technical Ecology Prototype Model

First-pass Forest variables:

```text
rabbit_population: 0–100
wolf_population: 0–100
berry_density: 0–100
slime_population: 0–100
soil_fertility: 0–100
fungus_level: 0–100
```

Possible daily rules:

```text
rabbit_population += reproduction_from_berry
rabbit_population -= predation_from_wolf
rabbit_population -= player_rabbit_kills

wolf_population += prey_availability
wolf_population -= starvation
wolf_population -= player_wolf_kills

berry_density += natural_regrowth
berry_density -= rabbit_consumption

soil_fertility += slime_decomposition
soil_fertility -= natural_depletion

fungus_level += fertility_factor
fungus_level += moisture_factor
fungus_level -= suppression_factor
```

Clamp all values safely.

Do not lock balancing constants yet.

---

# 52. Architecture Priority for Codex

Build reusable primitives first:

- Interaction component
- Health component
- Hitbox
- Hurtbox
- Damage handling
- Creature base state machine
- Species data resource
- Biome ecology state
- Spawn density controller
- Day transition
- Research discovery event
- Explicit save data structure

Do not hardcode all ecology inside creature scripts.

---

# 53. Success Definition

Wildroot succeeds if players naturally say:

- "I caused this."
- "I figured out how this creature works."
- "I wonder what happens if..."
- "I need this biome in a different state."
- "I can get that material without mindless grinding."
- "This farm setup works because these species help each other."
- "My world ended up different from someone else's."

The game should reward curiosity.

---

# 54. One-Sentence Rule

Whenever project direction becomes unclear, return to:

> **Wildroot is about understanding ecological relationships, deliberately changing them, and using the consequences to progress through a compact fantasy action RPG world.**

---

# 55. Immediate Next Development Target

Do not build the entire game.

Build:

## Wildroot Prototype 0.1 — Forest Ecology

Minimum:

```text
1 player
1 weapon

3 creatures:
- Rabbit
- Wolf
- Slime

2 wild plants:
- Berry
- Mushroom

3 small maps:
- Farm
- Forest
- Deep Forest

1 ecological anomaly:
- Mycelial Outbreak

1 boss:
- Mycelial King
```

Then add the rice-fish farm ecology proof.

Only expand after both loops are fun.

---

# 56. Final Design Principle

> **Wildroot is not about keeping nature perfect. It is about understanding what happens when nature changes.**

Do not punish experimentation merely for changing the environment.

The interesting part is:
- cause,
- consequence,
- discovery,
- adaptation,
- exploitation,
- restoration,
- and the player's relationship with the world they shaped.
