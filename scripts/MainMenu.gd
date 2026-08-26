extends Control

@onready var start_button = $VBoxContainer/StartButton
@onready var settings_button = $VBoxContainer/SettingsButton
@onready var quit_button = $VBoxContainer/QuitButton
@onready var high_score_label = $VBoxContainer/HighScoreLabel

func _ready():
	Input.set_custom_mouse_cursor(null)
	start_button.pressed.connect(_on_start_pressed)
	settings_button.pressed.connect(_on_settings_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	start_button.mouse_entered.connect(_on_button_hover)
	settings_button.mouse_entered.connect(_on_button_hover)
	quit_button.mouse_entered.connect(_on_button_hover)
	high_score_label.text = "Best Score: %d" % SaveData.high_score

func _on_button_hover():
	SFX.play("click", -16.0)

func _on_start_pressed():
	SFX.play("click")
	get_tree().change_scene_to_file("res://scenes/Main.tscn")

func _on_settings_pressed():
	SFX.play("click")
	get_tree().change_scene_to_file("res://scenes/Settings.tscn")

func _on_quit_pressed():
	SFX.play("click")
	get_tree().quit()
