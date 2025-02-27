extends Node2D

signal update_dialog(dialog)
signal show_dictionary()
signal start_dialog()
signal close_dialog()
signal stop_talking()
signal show_mushrooms()
@onready var dialogs = _load_json("res://dialogs/level-1-mushrooms-mission.json")
@onready var audio_player = $AudioStreamPlayer 
var mission_instructions: Array
var current_dialog_id = -1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if dialogs.is_empty():
		print("failed to load dialogs")
		return
	mission_instructions = dialogs.filter(_is_mission_dialog)
	#_get_next_dialog()
	emit_signal("show_dictionary")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _get_next_dialog():
	if current_dialog_id < dialogs.size()-1:
		current_dialog_id += 1
		var new_dialog = dialogs[current_dialog_id]
		print(new_dialog)
		emit_signal("update_dialog", new_dialog)
		_reproduce(new_dialog)
		if current_dialog_id == dialogs.size()-1: # mission has been explained
			emit_signal("show_mushrooms")

func _on_dialog_continue_button_pressed():
	_get_next_dialog()

func _reproduce(new_dialog):
	if new_dialog.has("audio") and new_dialog["audio"] != "":
		print("Playing audio:", new_dialog["audio"])
		_play_audio(new_dialog["audio"])
	else:
		print("No audio found for this dialog.")

func _play_audio(audio_path):
	if ResourceLoader.exists(audio_path): # Ensure file exists
		print("Audio file found:", audio_path)
		var audio_stream = load(audio_path) as AudioStream
		if audio_stream:
			audio_player.stream = audio_stream
			audio_player.play()
			print("Audio is playing.")
		else:
			print("Failed to load audio stream:", audio_path)
	else:
		print("Audio file not found:", audio_path)

func _load_json(path):
	var file = FileAccess.open(path, FileAccess.READ)
	if file:
		var content = file.get_as_text()
		return JSON.parse_string(content) if JSON.parse_string(content) else {}
	return {}

func _on_dialog_box_ignored():
	emit_signal("close_dialog")
	emit_signal("stop_talking")

func _on_mission_trigger_body_entered(body):
	if body.name == "Raccoon":
		dialogs = mission_instructions
		current_dialog_id = 0
		emit_signal("update_dialog", dialogs[current_dialog_id])
		_reproduce(dialogs[current_dialog_id])
		emit_signal("start_dialog")

func _is_mission_dialog(dictionary):
	if "category" in dictionary:
		return dictionary.category == "mission"
	else:
		return false

func _on_mentor_character_talking() -> void:
	_get_next_dialog()
