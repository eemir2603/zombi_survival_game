class_name Story
extends RefCounted

static var portrait_ryan = preload("res://sprites/ui/portrait_ryan.png")
static var portrait_sarah = preload("res://sprites/ui/portrait_sarah.png")
static var portrait_diane = preload("res://sprites/ui/portrait_diane.png")
static var portrait_briggs = preload("res://sprites/ui/portrait_briggs.png")
static var portrait_maya = preload("res://sprites/ui/portrait_maya.png")
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
	]

static func diary_log_1() -> Array:
	return [{"speaker": "Ryan's Journal", "portrait": portrait_ryan, "text": "Found my old army radio in the junk drawer. Still works. Habit, I guess - always double-checking my gear, even for a walk to the corner store."}]

static func diary_log_2() -> Array:
	return [{"speaker": "Ryan's Journal", "portrait": portrait_ryan, "text": "Emma drew a picture of the three of us on the fridge last week. Stick figures holding hands. I keep thinking about it."}]

static func diary_log_3() -> Array:
	return [{"speaker": "Ryan's Journal", "portrait": portrait_ryan, "text": "Sarah always said I worried too much, kept too many exits mapped out in my head. Funny how that habit's the only thing keeping me alive right now."}]

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
	return [{"speaker": "Nurse Diane", "portrait": portrait_diane, "text": "Route 9 checkpoint. Hold onto that thought - it's what's keeping you standing."}]

static func chapter2_outro() -> Array:
	return [
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "The hospital's as clear as it's going to get."},
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "Route 9 checkpoint. Hold on, Sarah. Emma. I'm close."},
	]

static func diary_log_4() -> Array:
	return [{"speaker": "Ryan's Journal", "portrait": portrait_ryan, "text": "Passed the pediatric ward. Empty cribs, some still made up. Made me think of Emma's room. Kept walking."}]

static func diary_log_5() -> Array:
	return [{"speaker": "Ryan's Journal", "portrait": portrait_ryan, "text": "Diane said she's been running this floor alone for two days. Didn't ask her to come with me. She offered before I could."}]

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
	return [{"speaker": "Sgt. Briggs", "portrait": portrait_briggs, "text": "Hold the line. Stadium's not far past this checkpoint - your family's close, Cole."}]

static func chapter3_outro() -> Array:
	return [
		{"speaker": "Sgt. Briggs", "portrait": portrait_briggs, "text": "Line's holding. Good work, Cole. I'm radioing the stadium now - they'll know you're coming."},
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "Thank you, Sergeant. Sarah, Emma - I'm almost there."},
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "There's a subway entrance a few blocks up - fastest way to cross the city without more checkpoints slowing me down."},
	]

static func diary_log_6() -> Array:
	return [{"speaker": "Ryan's Journal", "portrait": portrait_ryan, "text": "Briggs recognized my old unit patch before I even said a word. Small world, even in the middle of the end of it."}]

static func diary_log_7() -> Array:
	return [{"speaker": "Ryan's Journal", "portrait": portrait_ryan, "text": "One of the soldiers asked if I was scared. Told him no. Wasn't true. Scared doesn't stop you - it's what happens after that counts."}]

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
	return [{"speaker": "Torn Note", "portrait": portrait_note, "text": "\"If anyone finds this - the 9:15 never came. We're heading down the tunnel on foot. God help us.\""}]

static func found_note_2() -> Array:
	return [{"speaker": "Torn Note", "portrait": portrait_note, "text": "\"My brother didn't make it past the platform. I couldn't stop long enough to be sure he was really gone. I still hear him.\""}]

static func found_note_3() -> Array:
	return [{"speaker": "Torn Note", "portrait": portrait_note, "text": "\"Stadium relocation convoys are still running as of this morning. If you're reading this - keep moving. Don't stop for the sounds in the dark.\""}]

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
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "The tunnel climbs out past the east ridge. There's a relief camp up there - the last stop before the stadium."},
	]

static func chapter5_intro() -> Array:
	return [
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "Daylight. First time in hours. The relief camp sits in the mud below the ridge - tents, supply barrels, a few hundred people who made it this far."},
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "The perimeter fence is down on the east side. They know it. Everyone here knows it."},
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "Press 4 for the launcher if it gets bad. And it's going to get bad."},
	]

static func chapter5_maya_dialogue() -> Array:
	return [
		{"speaker": "Maya Reyes", "portrait": portrait_maya, "text": "You're the one Briggs called ahead about. Cole, right? He said you were coming through the tunnel. Didn't think anyone could."},
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "Sarah and Emma Cole. Convoy from the 5th Street hospital. Are they here?"},
		{"speaker": "Maya Reyes", "portrait": portrait_maya, "text": "They came through yesterday morning. Stayed one night, then went out on the last transport to the stadium. Your daughter was breathing easy by then - we had inhalers."},
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "She's okay. They're both okay."},
		{"speaker": "Maya Reyes", "portrait": portrait_maya, "text": "They were. But listen - that was the last transport. The horde came down off the ridge an hour after it left and we haven't been able to move anyone since."},
		{"speaker": "Maya Reyes", "portrait": portrait_maya, "text": "We've got maybe two hundred people in these tents and a fence that stopped being a fence this morning. If you can hold the east gap, I can get the rest of them loaded."},
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "Get them on the trucks. I'll hold it."},
	]

static func chapter5_maya_repeat() -> Array:
	return [{"speaker": "Maya Reyes", "portrait": portrait_maya, "text": "Still loading! Keep them off the tents - that's where the kids are."}]

static func chapter5_outro() -> Array:
	return [
		{"speaker": "Maya Reyes", "portrait": portrait_maya, "text": "That's everyone. Last truck is rolling. Cole - you did that. Two hundred people."},
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "Where's the stadium from here?"},
		{"speaker": "Maya Reyes", "portrait": portrait_maya, "text": "North road, twenty minutes by truck. There's a seat on the last one with your name on it."},
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "Sarah. Emma. One more stop."},
	]

static func diary_log_8() -> Array:
	return [{"speaker": "Ryan's Journal", "portrait": portrait_ryan, "text": "A kid in the second tent asked me if I was a soldier. Told her I used to be. She asked if I was going to stay. I didn't answer that one."}]

static func diary_log_9() -> Array:
	return [{"speaker": "Ryan's Journal", "portrait": portrait_ryan, "text": "Emma slept in one of these tents last night. Maya pointed out which one. I stood outside it for a full minute before I could make myself walk away."}]

static func diary_log_10() -> Array:
	return [{"speaker": "Ryan's Journal", "portrait": portrait_ryan, "text": "Maya's been awake for three days running this place. Nobody gave her the job. She just started doing it and nobody argued."}]

static var portrait_emma = preload("res://sprites/ui/portrait_emma.png")
static var portrait_sarah_hurt = preload("res://sprites/ui/portrait_sarah_hurt.png")

static func chapter6_intro() -> Array:
	return [
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "The stadium. Floodlights still burning off a generator somewhere. Someone's been keeping this place alive."},
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "The concourse gates are open. They shouldn't be open."},
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "Sarah. Emma. I'm here. Just hold on a little longer."},
	]

static func chapter6_found() -> Array:
	return [
		{"speaker": "Emma Cole", "portrait": portrait_emma, "text": "DAD! Dad, Dad - I told her you'd come, I TOLD her -"},
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "Emma. Oh my god. Come here. Let me look at you - you're okay, you're okay..."},
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "Sarah? Sarah, why are you sitting down - "},
		{"speaker": "Sarah Cole", "portrait": portrait_sarah_hurt, "text": "Hey. Hey, soldier. Took you long enough."},
		{"speaker": "Sarah Cole", "portrait": portrait_sarah_hurt, "text": "Don't. Don't do the face. It happened at the gate, about an hour ago. One of them came over the barrier and I was the one standing between it and her."},
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "No. No, we've got medics, there's a bus, we get you on that bus and -"},
		{"speaker": "Sarah Cole", "portrait": portrait_sarah_hurt, "text": "Ryan. Look at me."},
		{"speaker": "Sarah Cole", "portrait": portrait_sarah_hurt, "text": "There are two hundred people behind that fence and one bus. I'm not taking a seat from a kid who gets to keep theirs."},
		{"speaker": "Sarah Cole", "portrait": portrait_sarah_hurt, "text": "The driver needs about two minutes to get them all loaded. Two minutes, and they're gone. That's what you can do for me."},
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "...Two minutes."},
		{"speaker": "Sarah Cole", "portrait": portrait_sarah_hurt, "text": "Two minutes. Go. I've got her until you're done."},
	]

static func chapter6_defense_start() -> Array:
	return [
		{"speaker": "Bus Driver", "portrait": portrait_note, "text": "Loading now! Keep them off the bus - if they get to the engine block we're all walking!"},
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "Nobody touches that bus. Not one of them."},
	]

static func chapter6_defense_half() -> Array:
	return [{"speaker": "Bus Driver", "portrait": portrait_note, "text": "Half loaded! Keep holding!"}]

static func chapter6_ending() -> Array:
	return [
		{"speaker": "Bus Driver", "portrait": portrait_note, "text": "That's everyone! Doors closing - last seat, whoever's taking it, NOW!"},
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "Emma. Emma, listen to me. You're getting on that bus."},
		{"speaker": "Emma Cole", "portrait": portrait_emma, "text": "Not without you. Not without Mom. Dad - Dad, she's not getting up -"},
		{"speaker": "Sarah Cole", "portrait": portrait_sarah_hurt, "text": "Emma. Sweetheart. Look at me instead."},
		{"speaker": "Sarah Cole", "portrait": portrait_sarah_hurt, "text": "You remember the picture you drew? The three of us? You keep that. You keep all of it. That's where I'll be."},
		{"speaker": "Sarah Cole", "portrait": portrait_sarah_hurt, "text": "Now go with your father. Go on. I'm right here. I'm not going anywhere."},
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "Sarah -"},
		{"speaker": "Sarah Cole", "portrait": portrait_sarah_hurt, "text": "You found us. You crossed a dead city and you found us. Don't you dare call that losing."},
		{"speaker": "Sarah Cole", "portrait": portrait_sarah_hurt, "text": "Take her home, Ryan."},
		{"speaker": "???", "portrait": null, "text": "The bus pulls out through the north gate at 4:11 AM. Two hundred and six people aboard."},
		{"speaker": "???", "portrait": null, "text": "Ryan Cole holds his daughter the entire way and does not look back at the stadium, because he promised he wouldn't."},
		{"speaker": "Emma Cole", "portrait": portrait_emma, "text": "...Dad? Where are we going now?"},
		{"speaker": "Ryan Cole", "portrait": portrait_ryan, "text": "Home, sweetheart. Wherever we make it. We're going home."},
		{"speaker": "COMING HOME", "portrait": null, "text": "- THE END -"},
	]

static func diary_log_11() -> Array:
	return [{"speaker": "Ryan's Journal", "portrait": portrait_ryan, "text": "Somebody wrote names on the concourse wall in marker. Hundreds of them. Under each one, a date and a seat number. A record of who made it onto which bus."}]

static func diary_log_12() -> Array:
	return [{"speaker": "Ryan's Journal", "portrait": portrait_ryan, "text": "Found a kid's backpack by gate four with a school lunch still inside, untouched. I keep noticing the wrong things. I think it's easier than noticing the right ones."}]

static func diary_log_13() -> Array:
	return [{"speaker": "Ryan's Journal", "portrait": portrait_ryan, "text": "Every step across this city I rehearsed what I'd say when I found them. Now I'm standing in the tunnel under section C and I can't remember a single word of it."}]
