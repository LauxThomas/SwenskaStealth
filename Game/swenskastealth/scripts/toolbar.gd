extends CanvasLayer

@onready var dictionary = $Control/Dictionary
@onready var mushrooms = $Control/MushroomsCounter
@onready var yellow_mushrooms_counter = $Control/MushroomsCounter/YellowMushroomCounter
@onready var red_mushrooms_counter = $Control/MushroomsCounter/RedWhiteMushroomCounter
@onready var purple_mushrooms_counter = $Control/MushroomsCounter/PurpleMushroomCounter
@onready var audio_player = $AudioStreamPlayer  # Ensure this node exists in the scene

# Dictionary to reference UI labels dynamically
@onready var mushroom_labels = {
	"yellow": yellow_mushrooms_counter,
	"red": red_mushrooms_counter,
	"purple": purple_mushrooms_counter
}

# Updated base audio path
const AUDIO_BASE_PATH = "res://assets/audio/Player - Mushroom Mission/player-mm-"

# Audio suffix for each mushroom type
const AUDIO_SUFFIX = {
	"yellow": "-yellow.wav",  
	"red": "-red.wav",
	"purple": "-blue.wav"  
}

# Special "done" audio for completing a mushroom type
const COMPLETION_AUDIO_FILES = {
	"yellow": "res://assets/audio/Player - Mushroom Mission/player-mm-yellow-done.wav",
	"red": "res://assets/audio/Player - Mushroom Mission/player-mm-red-done.wav",
	"purple": "res://assets/audio/Player - Mushroom Mission/player-mm-blue-done.wav"
}

# Final mission completion audio
const MISSION_COMPLETE_AUDIO = "res://assets/audio/Player - Mushroom Mission/player-mm-mission-complete.wav"

# Required mushroom counts for mission completion
const REQUIRED_MUSHROOMS = {
	"yellow": 10,  
	"purple": 7,  
	"red": 3      
}

func _ready() -> void:
	dictionary.hide()
	mushrooms.hide()

func _on_show_dictionary():
	dictionary.show()

func _on_show_mushrooms() -> void:
	mushrooms.show()

func _on_update_mushrooms_counter(color: String, integer_value: int):
	if integer_value and integer_value > 0:
		var new_value = str(integer_value)
		if color in mushroom_labels:
			mushroom_labels[color].text = new_value  # Update UI label

		# Play the corresponding milestone audio
		_play_mushroom_audio(color, integer_value)

		# Check if this type is fully collected
		if integer_value == REQUIRED_MUSHROOMS[color]:
			_play_audio(COMPLETION_AUDIO_FILES[color])

		# Check for full mission completion
		if check_mission_complete():
			_play_audio(MISSION_COMPLETE_AUDIO)

func _play_mushroom_audio(color: String, count: int):
	if color in AUDIO_SUFFIX:
		var audio_path = AUDIO_BASE_PATH + str(count) + AUDIO_SUFFIX[color]
		_play_audio(audio_path)

func _play_audio(audio_path: String):
	if ResourceLoader.exists(audio_path):
		var audio_stream = load(audio_path) as AudioStream
		if audio_stream:
			audio_player.stream = audio_stream
			audio_player.play()
		else:
			print("❌ Failed to load audio stream:", audio_path)
	else:
		print("❌ Audio file not found:", audio_path)

func check_mission_complete() -> bool:
	for mushroom in REQUIRED_MUSHROOMS.keys():
		if mushroom_labels[mushroom].text.to_int() < REQUIRED_MUSHROOMS[mushroom]:
			return false  # Mission is not complete yet
	return true  # All required mushrooms are collected
