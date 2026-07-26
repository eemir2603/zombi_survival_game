extends CanvasLayer

@onready var health_label = $HealthLabel
@onready var score_label = $ScoreLabel
@onready var wave_label = $WaveLabel
@onready var game_over_panel = $GameOverPanel
@onready var game_over_label = $GameOverPanel/VBoxContainer/GameOverLabel
@onready var restart_button = $GameOverPanel/VBoxContainer/RestartButton

func _ready():
	game_over_panel.visible = false
	restart_button.pressed.connect(_on_restart_pressed)

func update_health(hp, max_hp):
	health_label.text = "Can: %d / %d" % [hp, max_hp]

func update_score(score):
	score_label.text = "Skor: %d" % score

func update_wave(wave):
	wave_label.text = "Dalga: %d" % wave

func show_game_over(score, wave):
	game_over_panel.visible = true
	game_over_label.text = "Öldün!\nSkor: %d\nUlaşılan Dalga: %d" % [score, wave]

func _on_restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
