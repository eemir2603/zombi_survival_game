extends Area2D

@export var log_lines: Array = []
var collected: bool = false

signal log_collected(lines)

func _ready():
	body_entered.connect(_on_body_entered)
	var tw = create_tween().set_loops()
	tw.tween_property(self, "rotation", 0.3, 0.8).set_trans(Tween.TRANS_SINE)
	tw.tween_property(self, "rotation", -0.3, 1.6).set_trans(Tween.TRANS_SINE)
	tw.tween_property(self, "rotation", 0.0, 0.8).set_trans(Tween.TRANS_SINE)

func _on_body_entered(body):
	if collected:
		return
	if body.is_in_group("player"):
		collected = true
		SFX.play("powerup", -4.0)
		log_collected.emit(log_lines)
		queue_free()
