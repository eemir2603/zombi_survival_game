class_name PowerUp
extends Area2D

enum Type { SPEED, MULTISHOT, HEAL }

@export var type: Type = Type.HEAL

func _ready():
	body_entered.connect(_on_body_entered)
	match type:
		Type.SPEED:
			$Polygon2D.color = Color(0.25, 0.55, 1.0, 1)
		Type.MULTISHOT:
			$Polygon2D.color = Color(1.0, 0.55, 0.1, 1)
		Type.HEAL:
			$Polygon2D.color = Color(1.0, 0.25, 0.6, 1)

	# Hafifce yukari asagi süzülsün
	var tw = create_tween().set_loops()
	tw.tween_property(self, "position:y", position.y - 6, 0.6).as_relative().set_trans(Tween.TRANS_SINE)
	tw.tween_property(self, "position:y", position.y + 6, 0.6).as_relative().set_trans(Tween.TRANS_SINE)

	# 10 saniyede alinmazsa kaybolsun
	var t = get_tree().create_timer(10.0)
	await t.timeout
	if is_instance_valid(self):
		queue_free()

func _on_body_entered(body):
	if body.is_in_group("player") and body.has_method("apply_powerup"):
		body.apply_powerup(type)
		SFX.play("powerup")
		queue_free()
