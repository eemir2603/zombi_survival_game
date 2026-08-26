extends Node2D

const CHAPTER_TARGET_WAVE = 3

const ZombieScene = preload("res://scenes/Zombie.tscn")
const PowerUpScene = preload("res://scenes/PowerUp.tscn")
const LootScene = preload("res://scenes/Loot.tscn")
const BossScene = preload("res://scenes/Boss.tscn")

var wave: int = 1
var zombies_alive: int = 0
var zombies_to_spawn: int = 0
var score: int = 0
var waves_done: bool = false
var f_was_pressed: bool = false

@onready var player = $Player
@onready var hud = $HUD
@onready var spawn_timer = $SpawnTimer
@onready var powerup_timer = $PowerUpTimer
@onready var dialogue_box = $DialogueBox
@onready var flashlight = $Player/Flashlight

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
	play_intro_story()

func _process(_delta):
	var f_pressed = Input.is_key_pressed(KEY_F)
	if f_pressed and not f_was_pressed:
		flashlight.enabled = not flashlight.enabled
		SFX.play("click", -10.0)
	f_was_pressed = f_pressed

func play_intro_story():
	dialogue_box.show_dialogue(Story.chapter4b_intro())
	await dialogue_box.finished
	start_wave()

func start_wave():
	zombies_to_spawn = 3 + wave * 2
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
	if roll < 0.3:
		return Zombie.ZombieType.TANKY
	elif roll < 0.6:
		return Zombie.ZombieType.FAST
	return Zombie.ZombieType.NORMAL

func get_random_spawn_position() -> Vector2:
	var vp = get_viewport_rect().size
	var edge = randi() % 4
	match edge:
		0:
			return Vector2(randf_range(0, vp.x), -50)
		1:
			return Vector2(vp.x + 50, randf_range(0, vp.y))
		2:
			return Vector2(randf_range(0, vp.x), vp.y + 50)
		_:
			return Vector2(-50, randf_range(0, vp.y))

func _on_zombie_died(zombie):
	var drop_pos = zombie.global_position
	zombies_alive -= 1
	score += 10
	hud.update_score(score)
	maybe_spawn_loot(drop_pos)
	check_wave_complete()

func maybe_spawn_loot(pos):
	var roll = randf()
	if roll < 0.25:
		var l = LootScene.instantiate()
		l.type = Loot.Type.AMMO
		add_child(l)
		l.global_position = pos
	elif roll < 0.4:
		var l = LootScene.instantiate()
		l.type = Loot.Type.HEALTH
		add_child(l)
		l.global_position = pos

func check_wave_complete():
	if zombies_to_spawn <= 0 and zombies_alive <= 0 and not waves_done:
		if wave >= CHAPTER_TARGET_WAVE:
			waves_done = true
			spawn_timer.stop()
			var timer = get_tree().create_timer(1.5)
			await timer.timeout
			start_boss_fight()
		else:
			wave += 1
			var timer2 = get_tree().create_timer(2.0)
			await timer2.timeout
			start_wave()

func start_boss_fight():
	dialogue_box.show_dialogue(Story.boss_intro())
	await dialogue_box.finished
	var boss = BossScene.instantiate()
	add_child(boss)
	boss.global_position = Vector2(576, 90)
	boss.health_changed.connect(_on_boss_health_changed)
	boss.died.connect(_on_boss_died)
	hud.show_boss_health("MUTATED HORROR", boss.max_health, boss.max_health)

func _on_boss_health_changed(current, max_hp):
	hud.update_boss_health(current, max_hp)

func _on_boss_died():
	hud.hide_boss_health()
	SaveData.unlock_rocket_launcher()
	var timer = get_tree().create_timer(1.0)
	await timer.timeout
	dialogue_box.show_dialogue(Story.boss_outro())
	await dialogue_box.finished
	hud.show_chapter_complete(score, "CHAPTER 4 COMPLETE", "")

func _on_continue_endless():
	wave += 1
	waves_done = false
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
