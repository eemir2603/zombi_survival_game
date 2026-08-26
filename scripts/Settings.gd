extends Control

@onready var volume_slider = $VBoxContainer/VolumeRow/VolumeSlider
@onready var crosshair_option = $VBoxContainer/CrosshairRow/CrosshairOption
@onready var color_option = $VBoxContainer/ColorRow/ColorOption
@onready var fps_checkbox = $VBoxContainer/FpsRow/FpsCheckBox
@onready var back_button = $VBoxContainer/BackButton

var crosshair_keys = ["classic", "dot", "cross", "off"]
var color_keys = ["green", "blue", "red", "grey"]

func _ready():
	Input.set_custom_mouse_cursor(null)

	volume_slider.value = SaveData.volume
	volume_slider.value_changed.connect(_on_volume_changed)

	crosshair_option.clear()
	crosshair_option.add_item("Classic", 0)
	crosshair_option.add_item("Dot", 1)
	crosshair_option.add_item("Cross", 2)
	crosshair_option.add_item("Off", 3)
	var current_idx = crosshair_keys.find(SaveData.crosshair_style)
	crosshair_option.select(max(current_idx, 0))
	crosshair_option.item_selected.connect(_on_crosshair_selected)

	color_option.clear()
	color_option.add_item("Green", 0)
	color_option.add_item("Blue", 1)
	color_option.add_item("Red", 2)
	color_option.add_item("Grey", 3)
	var color_idx = color_keys.find(SaveData.player_color)
	color_option.select(max(color_idx, 0))
	color_option.item_selected.connect(_on_color_selected)

	fps_checkbox.button_pressed = SaveData.show_fps
	fps_checkbox.toggled.connect(_on_fps_toggled)

	back_button.pressed.connect(_on_back_pressed)

func _on_volume_changed(value):
	SaveData.set_volume(value)

func _on_crosshair_selected(idx):
	SaveData.set_crosshair_style(crosshair_keys[idx])
	SFX.play("click", -10.0)

func _on_color_selected(idx):
	SaveData.set_player_color(color_keys[idx])
	SFX.play("click", -10.0)

func _on_fps_toggled(pressed):
	SaveData.set_show_fps(pressed)

func _on_back_pressed():
	SFX.play("click")
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
