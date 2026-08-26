class_name Boss
extends CharacterBody2D

@export var max_health: int = 500
@export var speed: float = 45.0
@export var melee_damage: int = 25
@export var melee_range: float = 60.0
@export var melee_cooldown: float = 1.2
@export var ranged_damage: int = 30
@export var ranged_cooldown: float = 2.4
@export var projectile_speed: float = 260.0

var health: int
var melee_timer: float = 0.0
var ranged_timer: float = 1.5
var player: Node2D = null
var is_dying: bool = false

signal health_changed(current, max_hp)
signal died

@onready var sprite = $Sprite2D
const BossProjectileScene = preload("res://scenes/BossProjectile.tscn")

func _ready():
	add_to_group("zombie")
	health = max_health
	player = get_tree().get_first_node_in_group("player")
	health_changed.emit(health, max_health)

func _physics_process(delta):
	if player == null or not is_instance_valid(player):
		return

	var dist = global_position.distance_to(player.global_position)
	var dir = (player.global_position - global_position).normalized()

	if dist > melee_range + 20.0:
		velocity = dir * speed
	else:
		velocity = Vector2.ZERO
	move_and_slide()

	look_at(player.global_position)

	melee_timer -= delta
	ranged_timer -= delta

	if dist <= melee_range and melee_timer <= 0:
		if player.has_method("take_damage"):
			player.take_damage(melee_damage)
		melee_timer = melee_cooldown

	if dist > melee_range and ranged_timer <= 0:
		fire_projectile(dir)
		ranged_timer = ranged_cooldown

func fire_projectile(dir: Vector2):
	SFX.play("zombie_groan", -6.0)
	var p = BossProjectileScene.instantiate()
	p.direction = dir
	p.damage = ranged_damage
	p.speed = projectile_speed
	get_parent().add_child(p)
	p.global_position = global_position

func take_damage(amount: int):
	if is_dying:
		return
	health -= amount
	health = max(health, 0)
	health_changed.emit(health, max_health)
	hit_flash()
	if health <= 0:
		die()

func hit_flash():
	sprite.modulate = Color(1.8, 1.4, 1.4)
	var tw = create_tween()
	tw.tween_property(sprite, "modulate", Color(1, 1, 1), 0.15)

func die():
	is_dying = true
	SFX.play("zombie_death", 3.0)
	died.emit()
	set_physics_process(false)
	$CollisionShape2D.set_deferred("disabled", true)
	var tw = create_tween()
	tw.set_parallel(true)
	tw.tween_property(sprite, "scale", sprite.scale * 1.4, 0.4)
	tw.tween_property(self, "modulate:a", 0.0, 0.6)
	tw.chain().tween_callback(queue_free)
