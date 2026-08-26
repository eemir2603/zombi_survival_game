class_name Loot
extends Area2D

enum Type { AMMO, HEALTH }

@export var type: Type = Type.AMMO

func _ready():
	body_entered.connect(_on_body_entered)
	match type:
		Type.AMMO:
			$Polygon2D.color = Color(0.85, 0.7, 0.2, 1)
		Type.HEALTH:
			$Polygon2D.color = Color(0.9, 0.2, 0.25, 1)

	var tw = create_tween().set_loops()
	tw.tween_property(self, "position:y", position.y - 5, 0.5).as_relative().set_trans(Tween.TRANS_SINE)
	tw.tween_property(self, "position:y", position.y + 5, 0.5).as_relative().set_trans(Tween.TRANS_SINE)

	var t = get_tree().create_timer(12.0)
	await t.timeout
	if is_instance_valid(self):
		queue_free()

func _on_body_entered(body):
	if body.is_in_group("player") and body.has_method("apply_loot"):
		body.apply_loot(type)
		SFX.play("powerup", -6.0)
		queue_free()
