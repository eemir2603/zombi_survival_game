extends CanvasLayer

signal continue_endless_requested

@onready var health_label = $HealthLabel
@onready var score_label = $ScoreLabel
@onready var wave_label = $WaveLabel
@onready var high_score_label = $HighScoreLabel
@onready var weapon_label = $WeaponLabel
@onready var ammo_label = $AmmoLabel
@onready var game_over_panel = $GameOverPanel
@onready var game_over_label = $GameOverPanel/VBoxContainer/GameOverLabel
@onready var restart_button = $GameOverPanel/VBoxContainer/RestartButton
@onready var main_menu_button = $GameOverPanel/VBoxContainer/MainMenuButton

@onready var chapter_panel = $ChapterCompletePanel
@onready var chapter_label = $ChapterCompletePanel/VBoxContainer/ChapterLabel
@onready var next_chapter_button = $ChapterCompletePanel/VBoxContainer/NextChapterButton
@onready var continue_button = $ChapterCompletePanel/VBoxContainer/ContinueButton
@onready var chapter_menu_button = $ChapterCompletePanel/VBoxContainer/ChapterMenuButton

@onready var boss_health_container = $BossHealthContainer
@onready var boss_name_label = $BossHealthContainer/BossNameLabel
@onready var boss_health_bar = $BossHealthContainer/BossHealthBar
@onready var fps_label = $FpsLabel

var next_chapter_scene: String = ""

func _ready():
	game_over_panel.visible = false
	chapter_panel.visible = false
	boss_health_container.visible = false
	fps_label.visible = SaveData.show_fps
	restart_button.pressed.connect(_on_restart_pressed)
	main_menu_button.pressed.connect(_on_main_menu_pressed)
	next_chapter_button.pressed.connect(_on_next_chapter_pressed)
	continue_button.pressed.connect(_on_continue_pressed)
	chapter_menu_button.pressed.connect(_on_chapter_menu_pressed)
	high_score_label.text = "Best: %d" % SaveData.high_score

func _process(_delta):
	if SaveData.show_fps:
		fps_label.visible = true
		fps_label.text = "FPS: %d" % Engine.get_frames_per_second()
	else:
		fps_label.visible = false

func update_health(hp, max_hp):
	health_label.text = "Health: %d / %d" % [hp, max_hp]

func update_score(score):
	score_label.text = "Score: %d" % score

func update_wave(wave):
	wave_label.text = "Wave: %d" % wave

func update_weapon(weapon_name):
	weapon_label.text = "Weapon: %s  (1/2/3 to switch, R to reload)" % weapon_name

func update_ammo(text):
	ammo_label.text = "Ammo: %s" % text

func show_boss_health(boss_name: String, current: int, max_hp: int):
	boss_health_container.visible = true
	boss_name_label.text = boss_name
	boss_health_bar.max_value = max_hp
	boss_health_bar.value = current

func update_boss_health(current: int, max_hp: int):
	boss_health_bar.max_value = max_hp
	boss_health_bar.value = current

func hide_boss_health():
	boss_health_container.visible = false

func show_game_over(score, wave):
	var is_new_record = SaveData.save_high_score(score)
	high_score_label.text = "Best: %d" % SaveData.high_score
	game_over_panel.visible = true

	var record_text = ""
	if is_new_record:
		record_text = "\n\nNEW RECORD!"
	else:
		record_text = "\n\nBest Score: %d" % SaveData.high_score

	game_over_label.text = "You Died\nScore: %d\nWave Reached: %d%s" % [score, wave, record_text]

func show_chapter_complete(score, chapter_title: String = "CHAPTER COMPLETE", next_scene_path: String = ""):
	SaveData.save_high_score(score)
	chapter_panel.visible = true
	get_tree().paused = true
	chapter_label.text = "%s\n\nScore: %d" % [chapter_title, score]

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
