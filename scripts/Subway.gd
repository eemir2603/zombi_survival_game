extends Node2D

@export var spawn_margin: float = 50.0
const CHAPTER_TARGET_WAVE = 3

const ZombieScene = preload("res://scenes/Zombie.tscn")
const PowerUpScene = preload("res://scenes/PowerUp.tscn")
const DiaryLogScene = preload("res://scenes/DiaryLog.tscn")
const LootScene = preload("res://scenes/Loot.tscn")

var wave: int = 1
var zombies_alive: int = 0
var zombies_to_spawn: int = 0
var score: int = 0
var chapter_complete: bool = false

@onready var player = $Player
@onready var hud = $HUD
@onready var spawn_timer = $SpawnTimer
@onready var powerup_timer = $PowerUpTimer
@onready var dialogue_box = $DialogueBox

func _ready():
	player.health_changed.connect(_on_player_health_changed)
	player.died.connect(_on_player_died)
	player.weapon_changed.connect(hud.update_weapon)
	player.ammo_changed.connect(hud.update_ammo)
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	powerup_timer.timeout.connect(_on_powerup_timer_timeout)
	hud.continue_endless_requested.connect(_on_continue_endless)
	hud.update_score(score)
	spawn_notes()
	play_intro_story()

func play_intro_story():
	dialogue_box.show_dialogue(Story.chapter4a_intro())
	await dialogue_box.finished
	start_wave()

func spawn_notes():
	var notes = [Story.found_note_1(), Story.found_note_2(), Story.found_note_3()]
	var positions = [Vector2(160, 250), Vector2(980, 250), Vector2(576, 130)]
	for i in notes.size():
		var d = DiaryLogScene.instantiate()
		d.log_lines = notes[i]
		add_child(d)
		d.global_position = positions[i]
		d.log_collected.connect(_on_log_collected)

func _on_log_collected(lines):
	dialogue_box.show_dialogue(lines)

func start_wave():
	zombies_to_spawn = 4 + wave * 2
	zombies_alive = 0
	hud.update_wave(wave)
	SFX.play("wave_start", -4.0)
	spawn_timer.start()

func _on_spawn_timer_timeout():
	if zombies_to_spawn <= 0:
		spawn_timer.stop()
		return
	spawn_zombie()
	zombies_to_spawn -= 1

func spawn_zombie():
	var z = ZombieScene.instantiate()
	z.zombie_type = pick_zombie_type()
	add_child(z)
	z.global_position = get_random_spawn_position()
	z.died.connect(_on_zombie_died)
	zombies_alive += 1

func pick_zombie_type():
	var roll = randf()
	if wave >= 3 and roll < 0.25:
		return Zombie.ZombieType.TANKY
	elif roll < 0.5:
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
	check_wave_complete()

func maybe_spawn_loot(pos):
	var roll = randf()
	if roll < 0.22:
		var l = LootScene.instantiate()
		l.type = Loot.Type.AMMO
		add_child(l)
		l.global_position = pos
	elif roll < 0.35:
		var l = LootScene.instantiate()
		l.type = Loot.Type.HEALTH
		add_child(l)
		l.global_position = pos

func check_wave_complete():
	if zombies_to_spawn <= 0 and zombies_alive <= 0:
		if wave >= CHAPTER_TARGET_WAVE and not chapter_complete:
			chapter_complete = true
			trigger_chapter_complete()
		else:
			wave += 1
			var timer = get_tree().create_timer(2.0)
			await timer.timeout
			start_wave()

func trigger_chapter_complete():
	spawn_timer.stop()
	powerup_timer.stop()
	var timer = get_tree().create_timer(1.0)
	await timer.timeout
	dialogue_box.show_dialogue(Story.chapter4a_outro())
	await dialogue_box.finished
	SaveData.carry_score = score
	get_tree().change_scene_to_file("res://scenes/Tunnel.tscn")

func _on_continue_endless():
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
	hud.show_game_over(score, wave)
	get_tree().paused = true
	spawn_timer.stop()
	powerup_timer.stop()
