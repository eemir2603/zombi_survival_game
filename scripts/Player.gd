extends CharacterBody2D

@export var speed: float = 250.0
@export var boost_speed: float = 400.0
@export var max_health: int = 100
@export var powerup_duration: float = 8.0

var health: int = 100
var can_shoot: bool = true
var is_reloading: bool = false
var speed_boost_timer: float = 0.0
var multishot_timer: float = 0.0
var r_was_pressed: bool = false

var current_weapon: String = "pistol"
var weapons := {
	"pistol": {"name": "Pistol", "cooldown": 0.25, "damage": 25, "pellets": 1, "spread": 0.0, "bullet_speed": 520.0, "infinite": true},
	"shotgun": {"name": "Shotgun", "cooldown": 0.65, "damage": 13, "pellets": 5, "spread": 0.4, "bullet_speed": 460.0, "infinite": false, "mag_size": 6, "max_mags": 4},
	"rifle": {"name": "Rifle", "cooldown": 0.09, "damage": 12, "pellets": 1, "spread": 0.06, "bullet_speed": 680.0, "infinite": false, "mag_size": 30, "max_mags": 4},
	"rocket": {"name": "Rocket Launcher", "cooldown": 1.4, "damage": 160, "pellets": 1, "spread": 0.0, "bullet_speed": 420.0, "infinite": false, "mag_size": 1, "max_mags": 4},
}
var ammo_state := {}

signal health_changed(new_health, max_health)
signal weapon_changed(weapon_name)
signal ammo_changed(display_text)
signal died

const BulletScene = preload("res://scenes/Bullet.tscn")

const CROSSHAIRS = {
	"classic": preload("res://sprites/ui/crosshair_classic.png"),
	"dot": preload("res://sprites/ui/crosshair_dot.png"),
	"cross": preload("res://sprites/ui/crosshair_cross.png"),
}
const PLAYER_TEXTURES = {
	"green": preload("res://sprites/player_green.png"),
	"blue": preload("res://sprites/player_blue.png"),
	"red": preload("res://sprites/player_red.png"),
	"grey": preload("res://sprites/player_grey.png"),
}

@onready var sprite = $Sprite2D

func _ready():
	add_to_group("player")
	health = max_health
	health_changed.emit(health, max_health)

	init_ammo_state()
	weapon_changed.emit(weapons[current_weapon].name)
	update_ammo_display()
	apply_settings()

func apply_settings():
	if PLAYER_TEXTURES.has(SaveData.player_color):
		sprite.texture = PLAYER_TEXTURES[SaveData.player_color]

	if SaveData.crosshair_style == "off":
		Input.set_custom_mouse_cursor(null)
	elif CROSSHAIRS.has(SaveData.crosshair_style):
		Input.set_custom_mouse_cursor(CROSSHAIRS[SaveData.crosshair_style], Input.CURSOR_ARROW, Vector2(20, 20))

func init_ammo_state():
	for key in weapons:
		var w = weapons[key]
		if not w.infinite:
			ammo_state[key] = {
				"current": w.mag_size,
				"reserve": w.mag_size * (w.max_mags - 1),
			}

func can_use_weapon(key: String) -> bool:
	if key == "rocket":
		return SaveData.has_rocket_launcher
	return true

func _physics_process(delta):
	if speed_boost_timer > 0:
		speed_boost_timer -= delta
	if multishot_timer > 0:
		multishot_timer -= delta

	handle_weapon_switch()
	handle_reload_input()

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

	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and can_shoot and not is_reloading:
		shoot()

func handle_weapon_switch():
	var new_weapon = current_weapon
	if Input.is_key_pressed(KEY_1):
		new_weapon = "pistol"
	elif Input.is_key_pressed(KEY_2):
		new_weapon = "shotgun"
	elif Input.is_key_pressed(KEY_3):
		new_weapon = "rifle"
	elif Input.is_key_pressed(KEY_4) and can_use_weapon("rocket"):
		new_weapon = "rocket"

	if new_weapon != current_weapon:
		current_weapon = new_weapon
		is_reloading = false
		weapon_changed.emit(weapons[current_weapon].name)
		update_ammo_display()
		SFX.play("click", -12.0)

func handle_reload_input():
	var r_pressed = Input.is_key_pressed(KEY_R)
	if r_pressed and not r_was_pressed:
		reload()
	r_was_pressed = r_pressed

func reload():
	var w = weapons[current_weapon]
	if w.infinite or is_reloading:
		return
	var ammo = ammo_state[current_weapon]
	if ammo.current >= w.mag_size or ammo.reserve <= 0:
		return
	is_reloading = true
	SFX.play("click", -4.0)
	update_ammo_display()
	var timer = get_tree().create_timer(1.2)
	await timer.timeout
	if not is_inside_tree():
		return
	var needed = w.mag_size - ammo.current
	var take = min(needed, ammo.reserve)
	ammo.current += take
	ammo.reserve -= take
	is_reloading = false
	update_ammo_display()

func shoot():
	var w = weapons[current_weapon]

	if not w.infinite:
		var ammo = ammo_state[current_weapon]
		if ammo.current <= 0:
			SFX.play("click", -8.0)
			return
		ammo.current -= 1
		update_ammo_display()

	can_shoot = false
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

func update_ammo_display():
	var w = weapons[current_weapon]
	if w.infinite:
		ammo_changed.emit("Infinite")
	elif is_reloading:
		ammo_changed.emit("Reloading...")
	else:
		var a = ammo_state[current_weapon]
		ammo_changed.emit("%d / %d" % [a.current, a.reserve])

func apply_powerup(type):
	match type:
		PowerUp.Type.SPEED:
			speed_boost_timer = powerup_duration
		PowerUp.Type.MULTISHOT:
			multishot_timer = powerup_duration
		PowerUp.Type.HEAL:
			health = min(health + 30, max_health)
			health_changed.emit(health, max_health)

func apply_loot(type):
	match type:
		Loot.Type.HEALTH:
			health = min(health + 20, max_health)
			health_changed.emit(health, max_health)
		Loot.Type.AMMO:
			var target = current_weapon
			if weapons[target].infinite:
				target = "shotgun" if randf() < 0.5 else "rifle"
			var w = weapons[target]
			var max_reserve = w.mag_size * (w.max_mags - 1)
			ammo_state[target].reserve = min(ammo_state[target].reserve + w.mag_size, max_reserve)
			if target == current_weapon:
				update_ammo_display()

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
