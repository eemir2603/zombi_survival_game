extends CharacterBody2D

@export var speed: float = 250.0
@export var max_health: int = 100
@export var shoot_cooldown: float = 0.25

var health: int = 100
var can_shoot: bool = true

signal health_changed(new_health, max_health)
signal died

const BulletScene = preload("res://scenes/Bullet.tscn")

func _ready():
	add_to_group("player")
	health = max_health
	health_changed.emit(health, max_health)

func _physics_process(_delta):
	var input_dir = Vector2.ZERO
	if Input.is_key_pressed(KEY_W):
		input_dir.y -= 1
	if Input.is_key_pressed(KEY_S):
		input_dir.y += 1
	if Input.is_key_pressed(KEY_A):
		input_dir.x -= 1
	if Input.is_key_pressed(KEY_D):
		input_dir.x += 1

	velocity = input_dir.normalized() * speed
	move_and_slide()

	look_at(get_global_mouse_position())

	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and can_shoot:
		shoot()

func shoot():
	can_shoot = false
	var bullet = BulletScene.instantiate()
	get_parent().add_child(bullet)
	bullet.global_position = global_position
	bullet.direction = (get_global_mouse_position() - global_position).normalized()

	var timer = get_tree().create_timer(shoot_cooldown)
	await timer.timeout
	can_shoot = true

func take_damage(amount: int):
	health -= amount
	health = max(health, 0)
	health_changed.emit(health, max_health)
	if health <= 0:
		died.emit()
		queue_free()
