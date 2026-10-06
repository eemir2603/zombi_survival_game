class_name Npc
extends Area2D

@export var texture: Texture2D
@export var dialogue_lines: Array = []

var player_in_range: bool = false
var e_was_pressed: bool = false

signal interacted(lines)

@onready var sprite = $Sprite2D
@onready var prompt = $PromptLabel

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	if texture:
		sprite.texture = texture
	prompt.visible = false

func _process(_delta):
	# gorunmez NPC (hikaye gelmeden sahnede bekleyen) etkilesime girmez
	var active = visible and not dialogue_lines.is_empty()
	prompt.visible = player_in_range and active
	var e_pressed = Input.is_key_pressed(KEY_E)
	if active and player_in_range and e_pressed and not e_was_pressed:
		interacted.emit(dialogue_lines)
	e_was_pressed = e_pressed

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
