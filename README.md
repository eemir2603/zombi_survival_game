## Coming Home — Zombie Wave Survival ##


# A story-driven, top-down twin-stick shooter and zombie survival game, built with Godot 4.3+.

#The Story

Ryan Cole is a former soldier turned security contractor. He was on duty when the outbreak first hit. By the time the city went into full lockdown, he was completely cut off from his wife, Sarah, and their daughter, Emma. Now, he has to fight his way across the ruins of a collapsed city to find them and bring them home.
 
# How to Play

 -Download Godot 4.3+.

 -Click "Import" and select the project.godot file in this folder.

 -Hit Play (▶).

 OR 

 You can play on itchio

# Controls
Key / Input	Action
WASD	Movement
Mouse	Aim (crosshair style can be changed in Settings)
Left Click	Shoot
R	Reload
E	Interact / Talk to NPCs
F	Toggle Flashlight (Tunnel level only)
1 / 2 / 3 / 4	Switch Weapons
Click / SPACE	Advance dialogue

# Chapters

  1.The Neighborhood — The opening sequence. Features Sarah's note and 3 lore journals.

  2.The Hospital — Meet Nurse Diane (NPC). Navigate through hospital bed and abandoned car blockades.

  3.Military Checkpoint — Fight alongside Sgt. Briggs and 2 allied soldiers near an overturned HMMWV.

  4.Subway Terminal → The Tunnel — A grim area filled with bodies, blood, and notes leading into a pitch-black tunnel (requires the flashlight via 'F'). Ends in a boss fight against the Mutated Horror, which drops the Rocket Launcher.

  5.Refugee Camp Outskirts — A muddy, makeshift camp featuring tents and barrel cover. Meet Maya Reyes (NPC) and fight off 6 waves alongside 2 civilian volunteers.

  6.The Stadium (NEW — FINALE) — A unique three-phase final chapter. Details below.

# Chapter 6: The Stadium — New Gameplay Mechanics

This chapter structurally breaks away from the rest of the game:

Phase 1 — The Approach. Standard wave-clearing gameplay for 3 waves until you reach the stadium concourse.

Phase 2 — The Reunion. Ryan finally finds Sarah and Emma. However, Sarah was bitten an hour ago while shielding Emma from an infected. There is only one seat left on the evacuation bus, and Sarah refuses to take it.

Phase 3 — Evac Defense. (Entirely new mechanic) There is no wave counter here—just a 120-second survival timer. Zombies spawn endlessly, and 45% of them will completely ignore the player to swarm the bus. The bus has its own health bar (700 HP). If it drops to zero, you fail the chapter ("THE BUS IS GONE"). Ammo and health drop rates are significantly boosted during this phase, making resource management critical. The UI displays the countdown timer and bus integrity.

Phase 4 — Finale. The bus fills up and pulls away. Sarah stays behind so Emma can live. Ryan takes his daughter and leaves without looking back, just as he promised Sarah he would.
Arsenal
Weapon	Magazine	Notes
Pistol	Unlimited	Balanced, reliable sidearm.
Shotgun	6 × 4	Fires 5 pellets. Devastating at close range.
Rifle	30 × 4	High rate of fire, excellent DPS.
Rocket Launcher	1 × 4	Unlocked after the Tunnel boss (Key 4).

Note: Defeated zombies have a chance to drop Ammo (yellow) or Health (red) pickups.
Settings (Main Menu → SETTINGS)

Customize your Master Volume, Crosshair Style (Classic/Dot/Cross/Off), Character Color (Green/Blue/Red/Grey), and toggle the FPS Counter. All preferences are saved persistently via user://save_data.json.
Technical Notes

  -All visual assets and sound effects were procedurally generated (using Python's PIL and wave modules). Absolutely zero external assets were used.

  -The flashlight in the Tunnel level is instantiated entirely via code in Tunnel.gd (PointLight2D.new()) rather than being embedded in the scene tree.

  -DialogueBox.gd includes get_viewport() null-checks and is_inside_tree() safeguards to prevent crashing during scene transitions.

# Project Structure
Plaintext

zombie_survival/

├── project.godot

├── audio/     # 9 procedurally generated .wav files

├── sprites/   # 13 character & 28 UI/environment .png files

├── scenes/    # 22 .tscn scene files

└── scripts/   # 25 .gd scripts

-- Roadmap / What's Next --

  1.Visual & Animation Polish: Implementing walk cycles, particle effects, and screen shake.

  2.Scoring: Adding kill streaks and a combo score multiplier.

  3.UI Enhancements: Adding a minimap / radar.

  4.Progression: An intermission screen between chapters for weapon selection and upgrades.
