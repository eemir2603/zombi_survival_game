extends CanvasLayer

@onready var health_label = $HealthLabel
@onready var score_label = $ScoreLabel
@onready var wave_label = $WaveLabel
@onready var high_score_label = $HighScoreLabel
@onready var game_over_panel = $GameOverPanel
@onready var game_over_label = $GameOverPanel/VBoxContainer/GameOverLabel
@onready var restart_button = $GameOverPanel/VBoxContainer/RestartButton
@onready var main_menu_button = $GameOverPanel/VBoxContainer/MainMenuButton

func _ready():
	game_over_panel.visible = false
	restart_button.pressed.connect(_on_restart_pressed)
	main_menu_button.pressed.connect(_on_main_menu_pressed)
	high_score_label.text = "Rekor: %d" % SaveData.high_score

func update_health(hp, max_hp):
	health_label.text = "Can: %d / %d" % [hp, max_hp]

func update_score(score):
	score_label.text = "Skor: %d" % score

func update_wave(wave):
	wave_label.text = "Dalga: %d" % wave

func show_game_over(score, wave):
	var is_new_record = SaveData.save_high_score(score)
	high_score_label.text = "Rekor: %d" % SaveData.high_score
	game_over_panel.visible = true

	var record_text = ""
	if is_new_record:
		record_text = "\n\nYENI REKOR!"
	else:
		record_text = "\n\nEn Yuksek Skor: %d" % SaveData.high_score

	game_over_label.text = "Oldun!\nSkor: %d\nUlasilan Dalga: %d%s" % [score, wave, record_text]

func _on_restart_pressed():
	SFX.play("click")
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_main_menu_pressed():
	SFX.play("click")
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
