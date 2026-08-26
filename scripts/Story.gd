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

static func chapter3_intro() -> Array:
	return [
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "Route 9. Concrete barriers, sandbags, a downed HMMWV blocking half the road."},
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "Still soldiers here. Good - if anyone knows where that convoy went, it's them."},
	]

static func chapter3_briggs_dialogue() -> Array:
	return [
		{"speaker": "Sgt. Briggs", "portrait": portrait_briggs, "text": "This is a restricted checkpoint, civilian. State your business or turn around."},
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "Ryan Cole, 3rd Battalion, discharged '19. I'm looking for my wife and daughter - a convoy came through here from the hospital."},
		{"speaker": "Sgt. Briggs", "portrait": portrait_briggs, "text": "...3rd Battalion. Alright. Yeah, a transport came through yesterday, civilians bound for the stadium relocation site."},
		{"speaker": "Sgt. Briggs", "portrait": portrait_briggs, "text": "Truth is, we're barely holding this line. If you help us clear this wave, I'll radio ahead and get you a lane through."},
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "Then let's get to work, Sergeant."},
	]

static func chapter3_briggs_repeat() -> Array:
	return [
		{"speaker": "Sgt. Briggs", "portrait": portrait_briggs, "text": "Hold the line. Stadium's not far past this checkpoint - your family's close, Cole."},
	]

static func chapter3_outro() -> Array:
	return [
		{"speaker": "Sgt. Briggs", "portrait": portrait_briggs, "text": "Line's holding. Good work, Cole. I'm radioing the stadium now - they'll know you're coming."},
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "Thank you, Sergeant. Sarah, Emma - I'm almost there."},
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "There's a subway entrance a few blocks up - fastest way to cross the city without more checkpoints slowing me down."},
	]

static func diary_log_6() -> Array:
	return [
		{"speaker": "Ryan's Journal", "portrait": portrait_ryan, "text": "Briggs recognized my old unit patch before I even said a word. Small world, even in the middle of the end of it."},
	]

static func diary_log_7() -> Array:
	return [
		{"speaker": "Ryan's Journal", "portrait": portrait_ryan, "text": "One of the soldiers asked if I was scared. Told him no. Wasn't true. Scared doesn't stop you - it's what happens after that counts."},
	]

static var portrait_torn_note = portrait_note

static func chapter4a_intro() -> Array:
	return [
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "Subway terminal. Turnstiles busted open, emergency lights still flickering."},
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "Looks like half the city tried to squeeze through here. Judging by what's left of them, not everyone made it."},
	]

static func chapter4a_outro() -> Array:
	return [
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "Platform's clear. There's only one way from here - down into the tunnel."},
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "No power down there. I'll need my flashlight - and steady hands."},
	]

static func found_note_1() -> Array:
	return [
		{"speaker": "Torn Note", "portrait": portrait_torn_note, "text": "\"If anyone finds this - the 9:15 never came. We're heading down the tunnel on foot. God help us.\""},
	]

static func found_note_2() -> Array:
	return [
		{"speaker": "Torn Note", "portrait": portrait_torn_note, "text": "\"My brother didn't make it past the platform. I couldn't stop long enough to be sure he was really gone. I still hear him.\""},
	]

static func found_note_3() -> Array:
	return [
		{"speaker": "Torn Note", "portrait": portrait_torn_note, "text": "\"Stadium relocation convoys are still running as of this morning. If you're reading this - keep moving. Don't stop for the sounds in the dark.\""},
	]

static func chapter4b_intro() -> Array:
	return [
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "Pitch black. Can't see three feet in front of me without the light."},
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "Press F. Steady the beam. Move slow."},
	]

static func boss_intro() -> Array:
	return [
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "...That's not a person. That's not even one of them. Whatever that thing is, it's massive."},
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "It's between me and the way out. No going around it. Time to finish this."},
	]

static func boss_outro() -> Array:
	return [
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "Down. Finally down."},
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "It was carrying military ordnance - a rocket launcher, still intact. Whoever it used to be, they were armed for a reason."},
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "I'll take it. Whatever's waiting at that stadium, I'm not walking in unprepared."},
		{"speaker": "???", "portrait": null, "text": "[Chapter 5 coming soon - the story continues]"},
	]
