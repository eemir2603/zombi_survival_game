extends Node2D

@export var spawn_margin: float = 50.0

const ZombieScene = preload("res://scenes/Zombie.tscn")

var wave: int = 1
var zombies_alive: int = 0
var zombies_to_spawn: int = 0
var score: int = 0

@onready var player = $Player
@onready var hud = $HUD
@onready var spawn_timer = $SpawnTimer

func _ready():
	player.health_changed.connect(_on_player_health_changed)
	player.died.connect(_on_player_died)
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	start_wave()

func start_wave():
	zombies_to_spawn = 4 + wave * 2
	zombies_alive = 0
	hud.update_wave(wave)
	spawn_timer.start()

func _on_spawn_timer_timeout():
	if zombies_to_spawn <= 0:
		spawn_timer.stop()
		return
	spawn_zombie()
	zombies_to_spawn -= 1

func spawn_zombie():
	var z = ZombieScene.instantiate()
	add_child(z)
	z.global_position = get_random_spawn_position()
	z.died.connect(_on_zombie_died)
	zombies_alive += 1

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

func _on_zombie_died(_zombie):
	zombies_alive -= 1
	score += 10
	hud.update_score(score)
	check_wave_complete()

func check_wave_complete():
	if zombies_to_spawn <= 0 and zombies_alive <= 0:
		wave += 1
		var timer = get_tree().create_timer(2.0)
		await timer.timeout
		start_wave()

func _on_player_health_changed(hp, max_hp):
	hud.update_health(hp, max_hp)

func _on_player_died():
	hud.show_game_over(score, wave)
	get_tree().paused = true
	spawn_timer.stop()
