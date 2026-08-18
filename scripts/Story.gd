class_name Story
extends RefCounted

static var portrait_ryan = preload("res://sprites/ui/portrait_ryan.png")
static var portrait_sarah = preload("res://sprites/ui/portrait_sarah.png")
static var portrait_diane = preload("res://sprites/ui/portrait_diane.png")
static var portrait_briggs = preload("res://sprites/ui/portrait_briggs.png")
static var portrait_note = preload("res://sprites/ui/portrait_note.png")

static func chapter1_intro() -> Array:
	return [
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "Three days on shift when the first reports came in. By the time they let us go, the roads were already gone."},
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "Sarah. Emma. I need to get home."},
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "The block is quiet. Too quiet. But quiet doesn't mean empty - not anymore."},
	]

static func chapter1_note() -> Array:
	return [
		{"speaker": "Sarah's Note", "portrait": portrait_note, "text": "\"Ryan - if you find this, we're okay. Emma's asthma flared up bad and we ran out of her inhaler.\""},
		{"speaker": "Sarah's Note", "portrait": portrait_note, "text": "\"We couldn't wait. Heading to the hospital on 5th - they still had power last I heard. Come find us. - S.\""},
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "The hospital. Alright. Hold on, both of you. I'm coming."},
	]

static func chapter1_outro() -> Array:
	return [
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "The street's clear enough for now. Whatever's left of it."},
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "5th Street hospital. That's the next stop."},
		{"speaker": "???", "portrait": null, "text": "[Bolum 2 yakinda - hikaye devam edecek]"},
	]

static func diary_log_1() -> Array:
	return [
		{"speaker": "Ryan's Journal", "portrait": portrait_ryan, "text": "Found my old army radio in the junk drawer. Still works. Habit, I guess - always double-checking my gear, even for a walk to the corner store."},
	]

static func diary_log_2() -> Array:
	return [
		{"speaker": "Ryan's Journal", "portrait": portrait_ryan, "text": "Emma drew a picture of the three of us on the fridge last week. Stick figures holding hands. I keep thinking about it."},
	]

static func diary_log_3() -> Array:
	return [
		{"speaker": "Ryan's Journal", "portrait": portrait_ryan, "text": "Sarah always said I worried too much, kept too many exits mapped out in my head. Funny how that habit's the only thing keeping me alive right now."},
	]
static var portrait_ryan2 = portrait_ryan
static var npc_diane_texture = preload("res://sprites/npc_diane.png")

static func chapter2_intro() -> Array:
	return [
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "5th Street Hospital. Half the windows are blown out. Doesn't look like anyone's in charge here anymore."},
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "If Sarah and Emma came through here, someone might know where they went next."},
	]

static func chapter2_diane_dialogue() -> Array:
	return [
		{"speaker": "Nurse Diane", "portrait": portrait_diane, "text": "You're looking for a woman and a little girl? Brown-haired, girl with an inhaler?"},
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "Yes - that's them. Sarah and Emma. Please, are they alright?"},
		{"speaker": "Nurse Diane", "portrait": portrait_diane, "text": "They were here. Stabilized the girl, then a military convoy came through evacuating civilians. They went with them."},
		{"speaker": "Nurse Diane", "portrait": portrait_diane, "text": "Checkpoint on Route 9, last I heard. It's not far. But it's not safe either - those things are getting through the barricades."},
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "Then I'll clear a path. Thank you, Diane. Stay behind me."},
	]

static func chapter2_diane_repeat() -> Array:
	return [
		{"speaker": "Nurse Diane", "portrait": portrait_diane, "text": "Route 9 checkpoint. Hold onto that thought - it's what's keeping you standing."},
	]

static func chapter2_outro() -> Array:
	return [
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "The hospital's as clear as it's going to get."},
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "Route 9 checkpoint. Hold on, Sarah. Emma. I'm close."},
		{"speaker": "???", "portrait": null, "text": "[Bolum 3 yakinda - hikaye devam edecek]"},
	]

static func diary_log_4() -> Array:
	return [
		{"speaker": "Ryan's Journal", "portrait": portrait_ryan, "text": "Passed the pediatric ward. Empty cribs, some still made up. Made me think of Emma's room. Kept walking."},
	]

static func diary_log_5() -> Array:
	return [
		{"speaker": "Ryan's Journal", "portrait": portrait_ryan, "text": "Diane said she's been running this floor alone for two days. Didn't ask her to come with me. She offered before I could."},
	]
