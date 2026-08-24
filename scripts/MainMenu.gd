extends Control

@onready var start_button = $VBoxContainer/StartButton
@onready var quit_button = $VBoxContainer/QuitButton
@onready var high_score_label = $VBoxContainer/HighScoreLabel
@onready var volume_slider = $VBoxContainer/VolumeRow/VolumeSlider

func _ready():
	Input.set_custom_mouse_cursor(null)
	start_button.pressed.connect(_on_start_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	start_button.mouse_entered.connect(_on_button_hover)
	quit_button.mouse_entered.connect(_on_button_hover)
	high_score_label.text = "En Yuksek Skor: %d" % SaveData.high_score

	var bus_idx = AudioServer.get_bus_index("Master")
	volume_slider.value = db_to_linear(AudioServer.get_bus_volume_db(bus_idx))
	volume_slider.value_changed.connect(_on_volume_changed)

func _on_volume_changed(value: float):
	var bus_idx = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(bus_idx, linear_to_db(max(value, 0.0001)))

func _on_button_hover():
	SFX.play("click", -16.0)

func _on_start_pressed():
	SFX.play("click")
	get_tree().change_scene_to_file("res://scenes/Main.tscn")

func _on_quit_pressed():
	SFX.play("click")
	get_tree().quit()
