extends Control

@onready var start_button = $VBoxContainer/StartButton
@onready var quit_button = $VBoxContainer/QuitButton
@onready var high_score_label = $VBoxContainer/HighScoreLabel

func _ready():
	start_button.pressed.connect(_on_start_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	high_score_label.text = "En Yuksek Skor: %d" % SaveData.high_score

func _on_start_pressed():
	SFX.play("click")
	get_tree().change_scene_to_file("res://scenes/Main.tscn")

func _on_quit_pressed():
	SFX.play("click")
	get_tree().quit()
