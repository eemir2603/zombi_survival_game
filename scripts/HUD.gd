extends CanvasLayer

signal continue_endless_requested

@onready var health_label = $HealthLabel
@onready var score_label = $ScoreLabel
@onready var wave_label = $WaveLabel
@onready var high_score_label = $HighScoreLabel
@onready var weapon_label = $WeaponLabel
@onready var game_over_panel = $GameOverPanel
@onready var game_over_label = $GameOverPanel/VBoxContainer/GameOverLabel
@onready var restart_button = $GameOverPanel/VBoxContainer/RestartButton
@onready var main_menu_button = $GameOverPanel/VBoxContainer/MainMenuButton

@onready var chapter_panel = $ChapterCompletePanel
@onready var chapter_label = $ChapterCompletePanel/VBoxContainer/ChapterLabel
@onready var next_chapter_button = $ChapterCompletePanel/VBoxContainer/NextChapterButton
@onready var continue_button = $ChapterCompletePanel/VBoxContainer/ContinueButton
@onready var chapter_menu_button = $ChapterCompletePanel/VBoxContainer/ChapterMenuButton

var next_chapter_scene: String = ""

func _ready():
	game_over_panel.visible = false
	chapter_panel.visible = false
	restart_button.pressed.connect(_on_restart_pressed)
	main_menu_button.pressed.connect(_on_main_menu_pressed)
	next_chapter_button.pressed.connect(_on_next_chapter_pressed)
	continue_button.pressed.connect(_on_continue_pressed)
	chapter_menu_button.pressed.connect(_on_chapter_menu_pressed)
	high_score_label.text = "Rekor: %d" % SaveData.high_score

func update_health(hp, max_hp):
	health_label.text = "Can: %d / %d" % [hp, max_hp]

func update_score(score):
	score_label.text = "Skor: %d" % score

func update_wave(wave):
	wave_label.text = "Dalga: %d" % wave

func update_weapon(weapon_name):
	weapon_label.text = "Silah: %s  (1/2/3 ile degistir)" % weapon_name

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

func show_chapter_complete(score, chapter_title: String = "BOLUM TAMAMLANDI", next_scene_path: String = ""):
	SaveData.save_high_score(score)
	chapter_panel.visible = true
	get_tree().paused = true
	chapter_label.text = "%s\n\nSkor: %d" % [chapter_title, score]

	next_chapter_scene = next_scene_path
	next_chapter_button.visible = next_scene_path != ""

func _on_restart_pressed():
	SFX.play("click")
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_main_menu_pressed():
	SFX.play("click")
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")

func _on_next_chapter_pressed():
	SFX.play("click")
	get_tree().paused = false
	get_tree().change_scene_to_file(next_chapter_scene)

func _on_continue_pressed():
	SFX.play("click")
	chapter_panel.visible = false
	get_tree().paused = false
	continue_endless_requested.emit()

func _on_chapter_menu_pressed():
	SFX.play("click")
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
