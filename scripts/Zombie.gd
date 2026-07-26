extends CharacterBody2D

@export var speed: float = 80.0
@export var damage: int = 10
@export var attack_cooldown: float = 1.0
@export var max_health: int = 30

var health: int
var attack_timer: float = 0.0
var player: Node2D = null

signal died(zombie)

func _ready():
	health = max_health
	player = get_tree().get_first_node_in_group("player")
	# Her zombi biraz farklı hızda olsun ki sürü tek blok gibi hareket etmesin
	speed += randf_range(-15.0, 15.0)

func _physics_process(delta):
	if player == null or not is_instance_valid(player):
		return

	var dir = (player.global_position - global_position).normalized()
	velocity = dir * speed
	move_and_slide()

	attack_timer -= delta
	if global_position.distance_to(player.global_position) < 26 and attack_timer <= 0:
		if player.has_method("take_damage"):
			player.take_damage(damage)
		attack_timer = attack_cooldown

func take_damage(amount: int):
	health -= amount
	if health <= 0:
		died.emit(self)
		queue_free()
