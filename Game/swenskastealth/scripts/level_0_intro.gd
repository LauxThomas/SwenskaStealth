extends Node2D

signal update_dialog(dialog)
signal show_dictionary()
signal start_dialog()
signal close_dialog()
@onready var dialogs = _load_json("res://dialogs/level-0-intro.json")
var current_dialog_id = -1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if dialogs.is_empty():
		print("failed to load dialogs")
		return
	_get_next_dialog()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _get_next_dialog():
	if current_dialog_id < dialogs.size()-1:
		current_dialog_id += 1
		if current_dialog_id == 4: #Mentor is talking about dictionary
			emit_signal("show_dictionary")
		var new_dialog = dialogs[current_dialog_id]
		print(new_dialog)
		emit_signal("update_dialog", new_dialog)

func _on_dialog_continue_button_pressed():
	_get_next_dialog()

func _load_json(path):
	var file = FileAccess.open(path, FileAccess.READ)
	if file:
		var content = file.get_as_text()
		return JSON.parse_string(content) if JSON.parse_string(content) else {}
	return {}

func _on_first_dialog_trigger_body_entered(body):
	#print("body entered trigger")
	emit_signal("start_dialog")

func _on_dialog_box_ignored():
	if current_dialog_id == dialogs.size()-1: #End of level is reached
		emit_signal("close_dialog")
