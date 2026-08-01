extends Node

var pool_size: int = 8
var players: Array[AudioStreamPlayer] = []

var sounds := {
	"shoot": preload("res://audio/shoot.wav"),
	"hit": preload("res://audio/hit.wav"),
	"zombie_death": preload("res://audio/zombie_death.wav"),
	"player_hurt": preload("res://audio/player_hurt.wav"),
	"powerup": preload("res://audio/powerup.wav"),
	"wave_start": preload("res://audio/wave_start.wav"),
	"game_over": preload("res://audio/game_over.wav"),
	"click": preload("res://audio/click.wav"),
}

func _ready():
	for i in pool_size:
		var p = AudioStreamPlayer.new()
		add_child(p)
		players.append(p)

func play(sound_name: String, volume_db: float = 0.0):
	if not sounds.has(sound_name):
		return
	for p in players:
		if not p.playing:
			p.stream = sounds[sound_name]
			p.volume_db = volume_db
			p.play()
			return
	players[0].stream = sounds[sound_name]
	players[0].volume_db = volume_db
	players[0].play()
