# `Fukai`
> **Prepare yourself for diving into the dungeon**.

The goal is going down as much as possible inside the `Tiers` of the dungeon.

> **Note**: For Game Jam limit N `Tiers`, when reached last game is completed

Start at your workstation:
- Buy `Resources` (using `Coins`)
- Craft `Resources`
- Prepare to dive into the dungeon

***

- 🎲: Main mechanics
- ⚠️: Attention when implementing
- ✏️: Good to have, not necessary
- 💡: Idea, may be added or not
- ❓: Possible problem to verify

***

## Buy `Resources` ("shop")
Use `Coins` gained to buy sheer resources:
- X `Coins` gained for every `Tier` passed
- `Coins` can be collected/found inside dungeon

## `Resources`
Materials that can be mixed to create `Weapons`, `Shields`, `Potions` ("crafting").

> `Resource` + `Resource` = `Resource`
> 
> `Resource` + `Resource` = `Potion`
> 
> `Resource` + `Resource` = `Weapon`
> 
> `Resource` + `Resource` = `Shield`

> **Note**: Each `Resource` occupies N space in the `Inventory` 👇

### `Potions`
Regain health.

They can only be bought, not crafted!

### `Weapons`
Tradeoff between space in `Inventory` and damage when attacking.

### `Shields`
Tradeoff between space in `Inventory` and resistance to attacks.

## Dive into dungeon
Select `Inventory` before leaving.

> 🎲 **Limited space available**: Make sure to leave some space for the `Resources` found in the dungeon

When `Inventory` is full, no more `Resources` can be collected.

> ✏️ Allow to drop object to collect something else

### Diving deeper
Start at `Tier` 1 and go down. `Tier` starts in one location and has one place where stairs go down.

`Tier` depth defines difficulty: `Enemies` stronger and more "rare" or "new" `Resources`.

Each time you finish a `Tier` you gained its depth, when you come down again you start from it.


### Generation ⚠️
Manually create N rooms, with random places assigned for `Enemies`, `Resources`, and `Coins`.

For each `Tier` select N random rooms, make some of the assigned places concrete instances, and connect each room. Define start and end. ⚠️

Deeper `Tier` makes `Enemies` stronger, `Resources` more scarce but also more rare.

> 💡 No `Enemy` in the player's initial room

### Come back workstation
After finishing each `Tier` you can come back to the workstation.

> 🎲 If you get killed while in a `Tier` **you lose all the `Resources` collected**

> **Important**: the `Experience` gained is not lost when killed! (Avoid being too weak and not being able to come back)

> 🎲 No crafting can be done while inside the dungeon

## Player
- Health: how much damage before killed
- Speed: how often movement (compared to `Enemies`)
- Attack: base damage (sum to `Weapon`)
- Defense: base defense (sum to `Shield`)


### Movement
4 directions, 1 tile at the time.

If same speed, each time player moves by 1 and `Enemy` moves 1.

When more speed you can move x2 before `Enemy` moves 1.

Each action spends x1 movement. Actions:
- Apply potion
- Move
- Attack
- Collect `Resource`

> 🎲 Walking on top of `Coin` automatically collects it (costs x1 movement)

### Attack
Only when nearby (1 tile close).

> 🎲 **Deal more damage sometimes (critical hit)**: Avoids that the battle is decided from the beginning.
> 
> Also the enemies have this.

> 🎲 **Damage not always the same** (+ or - by random)


### Leveling
Killing an `Enemy` gives you a possible loot and **more `Experience`**.

> 🎲 Leveling system: gain `Experience` grow your level, gives you better stats

> ✏️ Choose which ability (speed, health, attack, defense) to increase when reaching new level


## `Enemy`
Each has a `Level`, that defines the following:
- Health (how much damage before kill)
- Attack (how much damage inflicted)
- Speed (how often they move)
- Range (how close the player should be before chasing)
- ✏️ Loot
  - Frequency (how often dropping something)
  - Rare (how rare is the `Resource` dropped)

> 🎲 The `Level` and the health are displayed on top of the sprite, so that the player has a way to decide if she wants to attack the `Enemy` or not

States:
- Roaming: each turn move in a "random" direction, or not move at all
- Chase: start moving towards player (**Path finding** ⚠️)
- Attack: when player is nearby (next tile) attack


***

## Gameplay
- Start at workstation `/ or /` start directly inside `Tier` 1 (based on which one is easier to explain)

### Workstation
- Crafting screen
  - Choose 2 (or N ✏️) `Resources` to combine
- Buy screen
  - Buy new `Resources` using `Coin`
- Preparation screen
  - Select things to bring into the dungeon inside `Inventory`

> **Note**: Save previous `Inventory` when diving again

> **Note**: You can check at which `Tier` you are currently

Workstation is a **room where you walk**, and at each "edge" there is the crafting, buying, and a room to dive into the dungeon.

### Dungeon (`Tier`)
The game generates the rooms of the `Tier` based on the deepness.

The player starts at the "start location":
- Move 4 direction
- Use potion (give back health)
  - Add button to do it (keyboard) or click on screen
- Attack (only when enemy nearby)
  - Triggered when moving "into" an `Enemy`
- Collect (only when `Resource` nearby)
  - Triggered when moving "into" a `Resource`

At the same time, all the `Enemies` enter their state machine, moving based on the player's speed.

The player can always check her `Inventory` (how much space left) and health.

The goal is to reach the end.

> Exploration is not required, but it may give you more `Resources`, `Coins`, and `Experience`

Define a "final" `Tier`: when reached is game over (for the purpose of the Game Jam).

> **Important**: Make sure the game is not too long, 10-15 minutes for the Game Jam

***

## Extra ✏️
- Player ability tree to unlock after reaching a new level
  - Dash (move faster for N turns)
  - Special attacks (magic, distance attacks)
  - Gain back health without potion
- Breakable objects (rocks and chests) that cost N movements and give a rare `Resource`
- More `Enemies` movements
  - Sprint N tiles
  - Attack from the distance
  - Try to prevent the player from reaching the stairs (block the path)
- More `Enemies` sizes (N tiles)
  - Bigger, more powerful, slower, cannot pass through some doors
- Different dungeons
  - Each has different `Resources`, only found in a specific dungeon
  - Unique `Enemies` (sprites and abilities)
  - Progress through dungeons (complete one, move to another)


***


## Implementation

### Art
8x8 pixel art tileset. Assets all 8x8.

> ✏️ Higher resolution for crafting and buying "shop"

### Roadmap
- [x] Player and `Enemies` movement (4 directions)
- [x] Tilemap (walls and layers for `Enemies`, player, and collectibles)
- [x] Allow completing the `Tier` when moving on top of end stairs
- [x] Allow collecting `Resources` when nearby (do not move on top of it)
- [x] Allow getting coins when moving on top of them
- [x] `Enemy` shared properties
- [x] Allow attacking when something nearby
- [x] Player stats definition
- [x] Killing `Enemy` when health zero
- [x] `Enemy` state machine
- [x] Turn based movement for player and all `Enemies` (based on speed)
- [x] `Enemy` path finding towards the player
- [ ] Turn based system with actors speed
- [ ] Killing player when health zero (lose loot and come back to workstation)
- [x] Allow use `Potion` to gain back health
- [ ] Player leveling system (`Experience` points and grow next level)
- [ ] Room shared properties (locations of `Enemies`, `Resources`, `Coins`, plus start and end positions)
- [ ] Generate room concrete instance (based on current `Tier`)
- [ ] Create dungeon (connect rooms concrete instances)
- [ ] Store current `Tier`
- [ ] `Tier`-specific `Inventory` system
- [ ] `Enemy` concrete instances (based on current `Tier`)
- [ ] `Resources` definition (shared properties, concrete instances)
- [ ] `Weapons` definition
- [ ] `Shields` definition
- [ ] Allow crafting (selection of what to create, each showing how much and what `Resources` it costs)
- [ ] Allow buying (show how much `Coins` it cost, click to get)
- [ ] Store complete workstation `Inventory` (all `Resources`, `Coins`, `Weapons`, `Shields`, `Potions`)
- [ ] Prepare `Inventory` to go into dungeon

***

## TODO
- [ ] Enemies can move in the same position, since no collision is detected and they start moving at the same time
- [ ] Resources become solid like walls when inventory is full
- [ ] Implement attacking (defense) computations (add some randomness)
- [ ] Add randomness in `Enemy` range, so that you are not doomed to be followed when spotted
- [ ] Add indication that `Enemy` spotted you and it is following
- [ ] Do not move on top of `Resources` (only `Coins`)
- [ ] Allow short time between each player movement (not possible to keep button pressed and move indefinitely)
- [ ] `Resources`, `Coins`, and stairs have similar structure, worth refactoring from same model?
- [ ] Allow each `Coin` to have a different value (new `Coin` class with a random value assigned when creating the level)