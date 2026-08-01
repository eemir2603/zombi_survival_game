extends Node

const SAVE_PATH = "user://highscore.save"
var high_score: int = 0

func _ready():
	load_high_score()

func load_high_score():
	if FileAccess.file_exists(SAVE_PATH):
		var f = FileAccess.open(SAVE_PATH, FileAccess.READ)
		high_score = f.get_32()
		f.close()

# score > mevcut rekor ise kaydeder, yeni rekor olup olmadigini dondurur
func save_high_score(score: int) -> bool:
	if score > high_score:
		high_score = score
		var f = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
		f.store_32(high_score)
		f.close()
		return true
	return false
