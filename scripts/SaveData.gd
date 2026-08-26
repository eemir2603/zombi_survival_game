extends Node

const SAVE_PATH = "user://save_data.json"

var high_score: int = 0
var crosshair_style: String = "classic"
var player_color: String = "green"
var show_fps: bool = false
var volume: float = 1.0
var has_rocket_launcher: bool = false
var carry_score: int = 0  # sahneler arasi (Subway -> Tunnel) skor tasima, diske kaydedilmez

func _ready():
	load_data()
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(max(volume, 0.0001)))

func load_data():
	if FileAccess.file_exists(SAVE_PATH):
		var f = FileAccess.open(SAVE_PATH, FileAccess.READ)
		var text = f.get_as_text()
		f.close()
		var parsed = JSON.parse_string(text)
		if typeof(parsed) == TYPE_DICTIONARY:
			high_score = parsed.get("high_score", 0)
			crosshair_style = parsed.get("crosshair_style", "classic")
			player_color = parsed.get("player_color", "green")
			show_fps = parsed.get("show_fps", false)
			volume = parsed.get("volume", 1.0)
			has_rocket_launcher = parsed.get("has_rocket_launcher", false)

func save_data():
	var data = {
		"high_score": high_score,
		"crosshair_style": crosshair_style,
		"player_color": player_color,
		"show_fps": show_fps,
		"volume": volume,
		"has_rocket_launcher": has_rocket_launcher,
	}
	var f = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	f.store_string(JSON.stringify(data))
	f.close()

func save_high_score(score: int) -> bool:
	if score > high_score:
		high_score = score
		save_data()
		return true
	return false

func set_crosshair_style(style: String):
	crosshair_style = style
	save_data()

func set_player_color(color: String):
	player_color = color
	save_data()

func set_show_fps(v: bool):
	show_fps = v
	save_data()

func set_volume(v: float):
	volume = v
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(max(v, 0.0001)))
	save_data()

func unlock_rocket_launcher():
	has_rocket_launcher = true
	save_data()
