extends Node2D
class_name Ally

@export var texture: Texture2D
@export var attack_range: float = 340.0
@export var cooldown: float = 0.6
@export var damage: int = 16
@export var bullet_speed: float = 550.0

var fire_timer: float = 0.0

@onready var sprite = $Sprite2D

const BulletScene = preload("res://scenes/Bullet.tscn")

func _ready():
	if texture:
		sprite.texture = texture

func _process(delta):
	fire_timer -= delta
	var target = find_nearest_zombie()
	if target:
		look_at(target.global_position)
		if fire_timer <= 0:
			shoot(target)
			fire_timer = cooldown

func find_nearest_zombie():
	var zombies = get_tree().get_nodes_in_group("zombie")
	var nearest = null
	var nearest_dist = attack_range
	for z in zombies:
		if not is_instance_valid(z):
			continue
		var d = global_position.distance_to(z.global_position)
		if d < nearest_dist:
			nearest_dist = d
			nearest = z
	return nearest

func shoot(target):
	SFX.play("shoot", -16.0)
	var dir = (target.global_position - global_position).normalized()
	var bullet = BulletScene.instantiate()
	bullet.direction = dir
	bullet.damage = damage
	bullet.speed = bullet_speed
	get_parent().add_child(bullet)
	bullet.global_position = global_position
