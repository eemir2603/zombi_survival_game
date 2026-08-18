extends CharacterBody2D

@export var speed: float = 250.0
@export var boost_speed: float = 400.0
@export var max_health: int = 100
@export var powerup_duration: float = 8.0

var health: int = 100
var can_shoot: bool = true
var speed_boost_timer: float = 0.0
var multishot_timer: float = 0.0

var current_weapon: String = "pistol"
var weapons := {
	"pistol": {"name": "Tabanca", "cooldown": 0.25, "damage": 25, "pellets": 1, "spread": 0.0, "bullet_speed": 520.0},
	"shotgun": {"name": "Pompali", "cooldown": 0.65, "damage": 13, "pellets": 5, "spread": 0.4, "bullet_speed": 460.0},
	"rifle": {"name": "Tufek", "cooldown": 0.11, "damage": 13, "pellets": 1, "spread": 0.06, "bullet_speed": 680.0},
}

signal health_changed(new_health, max_health)
signal weapon_changed(weapon_name)
signal died

const BulletScene = preload("res://scenes/Bullet.tscn")

func _ready():
	add_to_group("player")
	health = max_health
	health_changed.emit(health, max_health)
	weapon_changed.emit(weapons[current_weapon].name)

func _physics_process(delta):
	if speed_boost_timer > 0:
		speed_boost_timer -= delta
	if multishot_timer > 0:
		multishot_timer -= delta

	handle_weapon_switch()

	var input_dir = Vector2.ZERO
	if Input.is_key_pressed(KEY_W):
		input_dir.y -= 1
	if Input.is_key_pressed(KEY_S):
		input_dir.y += 1
	if Input.is_key_pressed(KEY_A):
		input_dir.x -= 1
	if Input.is_key_pressed(KEY_D):
		input_dir.x += 1

	var current_speed = boost_speed if speed_boost_timer > 0 else speed
	velocity = input_dir.normalized() * current_speed
	move_and_slide()

	look_at(get_global_mouse_position())

	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and can_shoot:
		shoot()

func handle_weapon_switch():
	var new_weapon = current_weapon
	if Input.is_key_pressed(KEY_1):
		new_weapon = "pistol"
	elif Input.is_key_pressed(KEY_2):
		new_weapon = "shotgun"
	elif Input.is_key_pressed(KEY_3):
		new_weapon = "rifle"

	if new_weapon != current_weapon:
		current_weapon = new_weapon
		weapon_changed.emit(weapons[current_weapon].name)
		SFX.play("click", -12.0)

func shoot():
	can_shoot = false
	var w = weapons[current_weapon]
	SFX.play("shoot", -6.0)

	var base_dir = (get_global_mouse_position() - global_position).normalized()
	var pellet_count = w.pellets
	var spread = w.spread
	if multishot_timer > 0:
		pellet_count = max(pellet_count, 3)
		spread = max(spread, 0.3)

	if pellet_count == 1:
		spawn_bullet(base_dir, w.damage, w.bullet_speed)
	else:
		for i in pellet_count:
			var t = float(i) / float(pellet_count - 1)
			var angle_offset = lerp(-spread, spread, t)
			spawn_bullet(base_dir.rotated(angle_offset), w.damage, w.bullet_speed)

	var timer = get_tree().create_timer(w.cooldown)
	await timer.timeout
	can_shoot = true

func spawn_bullet(dir: Vector2, dmg: int, spd: float):
	var bullet = BulletScene.instantiate()
	bullet.direction = dir
	bullet.damage = dmg
	bullet.speed = spd
	get_parent().add_child(bullet)
	bullet.global_position = global_position

func apply_powerup(type):
	match type:
		PowerUp.Type.SPEED:
			speed_boost_timer = powerup_duration
		PowerUp.Type.MULTISHOT:
			multishot_timer = powerup_duration
		PowerUp.Type.HEAL:
			health = min(health + 30, max_health)
			health_changed.emit(health, max_health)

func take_damage(amount: int):
	health -= amount
	health = max(health, 0)
	health_changed.emit(health, max_health)
	SFX.play("player_hurt")
	flash_hit()
	if health <= 0:
		SFX.play("game_over")
		died.emit()
		queue_free()

func flash_hit():
	modulate = Color(1, 0.4, 0.4)
	var tw = create_tween()
	tw.tween_property(self, "modulate", Color(1, 1, 1), 0.2)
