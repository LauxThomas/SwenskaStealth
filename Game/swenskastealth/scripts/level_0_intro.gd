extends Node2D

signal update_dialog(dialog)
signal show_dictionary()
signal start_dialog()
signal close_dialog()
@onready var dialogs = _load_json("res://dialogs/level-0-intro.json")
@onready var audio_player = $AudioStreamPlayer 

var dialog_starting_index = -1
var current_dialog_id = dialog_starting_index

func _ready() -> void:
	if dialogs.is_empty():
		print("Failed to load dialogs")
		return
	#_get_next_dialog()

func _get_next_dialog():
	if current_dialog_id < dialogs.size() - 1:
		current_dialog_id += 1
		if current_dialog_id == 4: #Mentor is talking about dictionary
			emit_signal("show_dictionary")
		var new_dialog = dialogs[current_dialog_id]
		print("New dialog:", new_dialog)
		emit_signal("update_dialog", new_dialog)
		
		# Play the correct audio if it exists
		if new_dialog.has("audio") and new_dialog["audio"] != "":
			print("Playing audio:", new_dialog["audio"])
			_play_audio(new_dialog["audio"])
		else:
			print("No audio found for this dialog.")

func _on_dialog_continue_button_pressed():
	print("Continue button pressed.")
	_get_next_dialog()

func _load_json(path):
	print("Loading JSON from:", path)
	var file = FileAccess.open(path, FileAccess.READ)
	if file:
		var content = file.get_as_text()
		var parsed_json = JSON.parse_string(content)
		if parsed_json:
			print("Successfully loaded JSON:", parsed_json)
			return parsed_json
		else:
			print("Error parsing JSON from:", path)
			return {}
	else:
		print("Failed to open file:", path)
	return {}

func _on_first_dialog_trigger_body_entered(body):
	#print("body entered trigger")
	emit_signal("start_dialog")
	_get_next_dialog()

func _on_dialog_box_ignored():
	if current_dialog_id == dialogs.size()-1: #End of level is reached
		emit_signal("close_dialog")
func _play_audio(audio_path: String) -> void:
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


func _on_mentor_character_talking() -> void:
	_get_next_dialog()
