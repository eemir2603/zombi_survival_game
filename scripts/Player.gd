extends CharacterBody2D

@export var speed: float = 250.0
@export var boost_speed: float = 400.0
@export var max_health: int = 100
@export var shoot_cooldown: float = 0.25
@export var powerup_duration: float = 8.0

var health: int = 100
var can_shoot: bool = true
var speed_boost_timer: float = 0.0
var multishot_timer: float = 0.0

signal health_changed(new_health, max_health)
signal died

const BulletScene = preload("res://scenes/Bullet.tscn")

func _ready():
	add_to_group("player")
	health = max_health
	health_changed.emit(health, max_health)

func _physics_process(delta):
	if speed_boost_timer > 0:
		speed_boost_timer -= delta
	if multishot_timer > 0:
		multishot_timer -= delta

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

func shoot():
	can_shoot = false
	SFX.play("shoot", -6.0)

	var base_dir = (get_global_mouse_position() - global_position).normalized()
	if multishot_timer > 0:
		for angle_offset in [-0.25, 0.0, 0.25]:
			spawn_bullet(base_dir.rotated(angle_offset))
	else:
		spawn_bullet(base_dir)

	var timer = get_tree().create_timer(shoot_cooldown)
	await timer.timeout
	can_shoot = true

func spawn_bullet(dir: Vector2):
	var bullet = BulletScene.instantiate()
	get_parent().add_child(bullet)
	bullet.global_position = global_position
	bullet.direction = dir

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
