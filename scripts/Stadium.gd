extends Node2D

# ============================================================
# CHAPTER 6 - STADIUM (finale)
# Bu bolum diger bolumlerden farkli calisir:
#   Faz 1: normal dalga temizligi (gate'e ulasma)
#   Faz 2: Sarah ve Emma bulunur (ara sahne, isirilmis)
#   Faz 3: ZAMANLI TAHLIYE SAVUNMASI - dalga saymak yok, sure var.
#          Zombiler surekli gelir, bir kismi OTOBUSE saldirir.
#          Otobusun cani biterse bolum kaybedilir.
#   Faz 4: final sahnesi
# ============================================================

@export var spawn_margin: float = 50.0
const APPROACH_TARGET_WAVE = 3
const DEFENSE_DURATION := 120.0
const DEFENSE_SPAWN_INTERVAL := 0.55
const OBJECTIVE_TARGET_CHANCE := 0.45

const ZombieScene = preload("res://scenes/Zombie.tscn")
const PowerUpScene = preload("res://scenes/PowerUp.tscn")
const DiaryLogScene = preload("res://scenes/DiaryLog.tscn")
const LootScene = preload("res://scenes/Loot.tscn")

enum Phase { APPROACH, REUNION, DEFENSE, ENDING }
var phase: int = Phase.APPROACH

var wave: int = 1
var zombies_alive: int = 0
var zombies_to_spawn: int = 0
var score: int = 0
var approach_done: bool = false

var defense_elapsed: float = 0.0
var defense_spawn_timer: float = 0.0
var half_announced: bool = false
var defense_running: bool = false
var failed: bool = false

@onready var player = $Player
@onready var hud = $HUD
@onready var spawn_timer = $SpawnTimer
@onready var powerup_timer = $PowerUpTimer
@onready var dialogue_box = $DialogueBox
@onready var sarah = $Sarah
@onready var emma = $Emma
@onready var evac_bus = $EvacBus

func _ready():
	score = SaveData.carry_score
	player.health_changed.connect(_on_player_health_changed)
	player.died.connect(_on_player_died)
	player.weapon_changed.connect(hud.update_weapon)
	player.ammo_changed.connect(hud.update_ammo)
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	powerup_timer.timeout.connect(_on_powerup_timer_timeout)
	hud.continue_endless_requested.connect(_on_continue_endless)
	hud.update_score(score)

	sarah.interacted.connect(_on_npc_interacted)
	emma.interacted.connect(_on_npc_interacted)
	sarah.visible = false
	emma.visible = false
	evac_bus.visible = false

	evac_bus.health_changed.connect(_on_bus_health_changed)
	evac_bus.destroyed.connect(_on_bus_destroyed)

	spawn_notes()
	play_intro_story()

func _process(delta):
	if not defense_running or failed:
		return

	defense_elapsed += delta
	hud.update_objective_progress(defense_elapsed, DEFENSE_DURATION)

	if not half_announced and defense_elapsed >= DEFENSE_DURATION * 0.5:
		half_announced = true
		dialogue_box.show_dialogue(Story.chapter6_defense_half())

	defense_spawn_timer -= delta
	if defense_spawn_timer <= 0:
		spawn_defense_zombie()
		defense_spawn_timer = DEFENSE_SPAWN_INTERVAL

	if defense_elapsed >= DEFENSE_DURATION:
		finish_defense()

# ---------------- FAZ 1: YAKLASMA ----------------

func play_intro_story():
	dialogue_box.show_dialogue(Story.chapter6_intro())
	await dialogue_box.finished
	start_wave()

func start_wave():
	zombies_to_spawn = 5 + wave * 2
	zombies_alive = 0
	hud.update_wave(wave)
	SFX.play("wave_start", -4.0)
	spawn_timer.start()

func _on_spawn_timer_timeout():
	if zombies_to_spawn <= 0:
		spawn_timer.stop()
		return
	spawn_zombie(false)
	zombies_to_spawn -= 1

func spawn_zombie(target_bus: bool):
	var z = ZombieScene.instantiate()
	z.zombie_type = pick_zombie_type()
	z.targets_objective = target_bus
	add_child(z)
	z.global_position = get_random_spawn_position()
	z.died.connect(_on_zombie_died)
	zombies_alive += 1

func pick_zombie_type():
	var roll = randf()
	if roll < 0.32:
		return Zombie.ZombieType.TANKY
	elif roll < 0.62:
		return Zombie.ZombieType.FAST
	return Zombie.ZombieType.NORMAL

func get_random_spawn_position() -> Vector2:
	var vp = get_viewport_rect().size
	var edge = randi() % 4
	match edge:
		0:
			return Vector2(randf_range(0, vp.x), -spawn_margin)
		1:
			return Vector2(vp.x + spawn_margin, randf_range(0, vp.y))
		2:
			return Vector2(randf_range(0, vp.x), vp.y + spawn_margin)
		_:
			return Vector2(-spawn_margin, randf_range(0, vp.y))

func _on_zombie_died(zombie):
	var drop_pos = zombie.global_position
	zombies_alive -= 1
	score += 10
	hud.update_score(score)
	maybe_spawn_loot(drop_pos)
	if phase == Phase.APPROACH:
		check_wave_complete()

func maybe_spawn_loot(pos):
	var roll = randf()
	# savunma fazinda daha comert - mermi yonetimi kritik
	var ammo_chance = 0.34 if phase == Phase.DEFENSE else 0.22
	var health_chance = ammo_chance + 0.14
	if roll < ammo_chance:
		var l = LootScene.instantiate()
		l.type = Loot.Type.AMMO
		add_child(l)
		l.global_position = pos
	elif roll < health_chance:
		var l = LootScene.instantiate()
		l.type = Loot.Type.HEALTH
		add_child(l)
		l.global_position = pos

func check_wave_complete():
	if zombies_to_spawn <= 0 and zombies_alive <= 0:
		if wave >= APPROACH_TARGET_WAVE and not approach_done:
			approach_done = true
			start_reunion()
		else:
			wave += 1
			var timer = get_tree().create_timer(2.0)
			await timer.timeout
			start_wave()

# ---------------- FAZ 2: KAVUSMA ----------------

func start_reunion():
	phase = Phase.REUNION
	spawn_timer.stop()
	powerup_timer.stop()
	var timer = get_tree().create_timer(1.2)
	await timer.timeout

	sarah.visible = true
	emma.visible = true
	evac_bus.visible = true

	dialogue_box.show_dialogue(Story.chapter6_found())
	await dialogue_box.finished
	start_defense()

func _on_npc_interacted(lines):
	dialogue_box.show_dialogue(lines)

# ---------------- FAZ 3: TAHLIYE SAVUNMASI ----------------

func start_defense():
	phase = Phase.DEFENSE
	sarah.dialogue_lines = Story.chapter6_defense_half()
	emma.dialogue_lines = Story.chapter6_defense_half()

	dialogue_box.show_dialogue(Story.chapter6_defense_start())
	await dialogue_box.finished

	hud.show_objective("EVACUATION IN PROGRESS", "BUS INTEGRITY")
	hud.update_objective_health(evac_bus.health, evac_bus.max_health)
	hud.update_objective_progress(0.0, DEFENSE_DURATION)

	powerup_timer.start()
	defense_elapsed = 0.0
	defense_spawn_timer = 0.0
	defense_running = true

func spawn_defense_zombie():
	# zombilerin bir kismi oyuncuyu gormezden gelip otobuse yonelir
	var target_bus = randf() < OBJECTIVE_TARGET_CHANCE
	spawn_zombie(target_bus)

func _on_bus_health_changed(current, max_hp):
	hud.update_objective_health(current, max_hp)

func _on_bus_destroyed():
	if failed:
		return
	failed = true
	defense_running = false
	powerup_timer.stop()
	hud.hide_objective()
	SFX.play("game_over")
	hud.show_game_over(score, wave, "THE BUS IS GONE\nThe evacuation failed.")
	get_tree().paused = true

func finish_defense():
	defense_running = false
	powerup_timer.stop()
	hud.hide_objective()
	phase = Phase.ENDING

	# kalan zombileri temizle - final sahnesi kesintiye ugramasin
	for z in get_tree().get_nodes_in_group("zombie"):
		if is_instance_valid(z):
			z.queue_free()

	var timer = get_tree().create_timer(1.0)
	await timer.timeout
	dialogue_box.show_dialogue(Story.chapter6_ending())
	await dialogue_box.finished
	hud.show_chapter_complete(score, "COMING HOME  -  COMPLETE", "")

# ---------------- ORTAK ----------------

func spawn_notes():
	var notes = [Story.diary_log_11(), Story.diary_log_12(), Story.diary_log_13()]
	var positions = [Vector2(150, 250), Vector2(1010, 250), Vector2(576, 210)]
	for i in notes.size():
		var d = DiaryLogScene.instantiate()
		d.log_lines = notes[i]
		add_child(d)
		d.global_position = positions[i]
		d.log_collected.connect(_on_log_collected)

func _on_log_collected(lines):
	dialogue_box.show_dialogue(lines)

func _on_continue_endless():
	# final sonrasi sonsuz mod
	phase = Phase.APPROACH
	approach_done = true
	wave += 1
	start_wave()

func _on_powerup_timer_timeout():
	var p = PowerUpScene.instantiate()
	var types = [PowerUp.Type.SPEED, PowerUp.Type.MULTISHOT, PowerUp.Type.HEAL]
	p.type = types[randi() % types.size()]
	add_child(p)
	var vp = get_viewport_rect().size
	p.global_position = Vector2(randf_range(60, vp.x - 60), randf_range(60, vp.y - 60))

func _on_player_health_changed(hp, max_hp):
	hud.update_health(hp, max_hp)

func _on_player_died():
	defense_running = false
	hud.hide_objective()
	hud.show_game_over(score, wave)
	get_tree().paused = true
	spawn_timer.stop()
	powerup_timer.stop()
