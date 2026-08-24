class_name Zombie
extends CharacterBody2D

enum ZombieType { NORMAL, FAST, TANKY }

@export var zombie_type: ZombieType = ZombieType.NORMAL
@export var damage: int = 10
@export var attack_cooldown: float = 1.0
@export var attack_range: float = 40.0  # fiziksel collision yaricaplari toplamindan (17+15=32) buyuk olmali, yoksa zombi hic bu mesafeye giremez

@export var texture_normal: Texture2D
@export var texture_fast: Texture2D
@export var texture_tanky: Texture2D

var speed: float = 80.0
var max_health: int = 30
var health: int
var attack_timer: float = 0.0
var groan_timer: float = 0.0
var player: Node2D = null
var is_dying: bool = false
var bob_offset: float = 0.0

@onready var sprite = $Sprite2D

signal died(zombie)

func _ready():
	add_to_group("zombie")
	bob_offset = randf() * TAU
	groan_timer = randf_range(0.5, 3.5)
	match zombie_type:
		ZombieType.NORMAL:
			speed = 80.0
			max_health = 30
			damage = 10
			sprite.texture = texture_normal
		ZombieType.FAST:
			speed = 145.0
			max_health = 15
			damage = 6
			sprite.texture = texture_fast
		ZombieType.TANKY:
			speed = 50.0
			max_health = 75
			damage = 18
			sprite.texture = texture_tanky
			scale = Vector2(1.2, 1.2)
			attack_range = 46.0  # daha buyuk govde, daha genis erisim

	speed += randf_range(-10.0, 10.0)
	health = max_health
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
	if player == null or not is_instance_valid(player):
		return

	var dir = (player.global_position - global_position).normalized()
	velocity = dir * speed
	move_and_slide()

	look_at(player.global_position)

	var bob = sin(Time.get_ticks_msec() / 1000.0 * 8.0 + bob_offset) * 0.06
	sprite.scale = Vector2(1.0 + bob, 1.0 - bob)

	attack_timer -= delta
	if global_position.distance_to(player.global_position) < attack_range and attack_timer <= 0:
		if player.has_method("take_damage"):
			player.take_damage(damage)
		attack_timer = attack_cooldown

	groan_timer -= delta
	if groan_timer <= 0:
		SFX.play("zombie_groan", -14.0)
		groan_timer = randf_range(4.0, 9.0)

func take_damage(amount: int):
	if is_dying:
		return
	health -= amount
	if health <= 0:
		die()
	else:
		SFX.play("hit", -10.0)
		hit_flash()

func die():
	is_dying = true
	SFX.play("zombie_death", -4.0)
	died.emit(self)
	$CollisionShape2D.set_deferred("disabled", true)
	set_physics_process(false)
	var tw = create_tween()
	tw.set_parallel(true)
	tw.tween_property(sprite, "scale", Vector2.ZERO, 0.2)
	tw.tween_property(self, "modulate:a", 0.0, 0.2)
	tw.chain().tween_callback(queue_free)

func hit_flash():
	sprite.modulate = Color(1.8, 1.4, 1.4)
	var tw = create_tween()
	tw.tween_property(sprite, "modulate", Color(1, 1, 1), 0.15)
