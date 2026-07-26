extends Area2D

var direction: Vector2 = Vector2.RIGHT
var speed: float = 500.0
var damage: int = 25
var lifetime: float = 2.0

func _ready():
	rotation = direction.angle()
	body_entered.connect(_on_body_entered)

	var timer = get_tree().create_timer(lifetime)
	await timer.timeout
	queue_free()

func _physics_process(delta):
	position += direction * speed * delta

func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
	queue_free()
