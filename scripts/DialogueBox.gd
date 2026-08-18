extends CanvasLayer

signal finished

@onready var panel = $Panel
@onready var portrait_rect = $Panel/HBoxContainer/PortraitRect
@onready var name_label = $Panel/HBoxContainer/VBoxContainer/NameLabel
@onready var text_label = $Panel/HBoxContainer/VBoxContainer/TextLabel
@onready var continue_label = $Panel/ContinueLabel

var lines: Array = []
var current_index: int = 0
var is_typing: bool = false
var full_text: String = ""
var char_index: int = 0
var type_speed: float = 0.02
var type_timer: float = 0.0

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = false

func show_dialogue(dialogue_lines: Array):
	lines = dialogue_lines
	current_index = 0
	visible = true
	get_tree().paused = true
	display_line()

func display_line():
	if current_index >= lines.size():
		end_dialogue()
		return
	var line = lines[current_index]
	name_label.text = line.get("speaker", "")

	var portrait = line.get("portrait", null)
	if portrait != null:
		portrait_rect.texture = portrait
		portrait_rect.visible = true
	else:
		portrait_rect.visible = false

	full_text = line.get("text", "")
	char_index = 0
	type_timer = 0.0
	text_label.text = ""
	is_typing = true

func _process(delta):
	if not visible or not is_typing:
		return
	type_timer += delta
	while type_timer >= type_speed and char_index < full_text.length():
		type_timer -= type_speed
		char_index += 1
		text_label.text = full_text.substr(0, char_index)
	if char_index >= full_text.length():
		is_typing = false

func _unhandled_input(event):
	if not visible:
		return
	var advance_pressed = false
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		advance_pressed = true
	elif event is InputEventKey and event.pressed and (event.keycode == KEY_SPACE or event.keycode == KEY_ENTER):
		advance_pressed = true

	if advance_pressed:
		advance()
		get_viewport().set_input_as_handled()

func advance():
	if is_typing:
		text_label.text = full_text
		is_typing = false
	else:
		current_index += 1
		display_line()

func end_dialogue():
	visible = false
	get_tree().paused = false
	finished.emit()
