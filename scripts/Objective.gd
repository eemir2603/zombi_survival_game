class_name Objective
extends StaticBody2D

@export var texture: Texture2D
@export var max_health: int = 700

var health: int
var is_destroyed: bool = false

signal health_changed(current, max_hp)
signal destroyed

@onready var sprite = $Sprite2D

func _ready():
	add_to_group("objective")
	health = max_health
	if texture:
		sprite.texture = texture
	health_changed.emit(health, max_health)

func take_damage(amount: int):
	if is_destroyed:
		return
	health -= amount
	health = max(health, 0)
	health_changed.emit(health, max_health)
	hit_flash()
	if health <= 0:
		is_destroyed = true
		destroyed.emit()

func hit_flash():
	sprite.modulate = Color(1.7, 1.2, 1.2)
	var tw = create_tween()
	tw.tween_property(sprite, "modulate", Color(1, 1, 1), 0.18)
