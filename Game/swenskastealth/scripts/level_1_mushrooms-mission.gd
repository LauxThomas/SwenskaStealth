extends Node2D

signal update_dialog(dialog)
signal start_dialog()
signal close_dialog()
signal stop_talking()
@onready var dialogs = _load_json("res://dialogs/level-1-mushrooms-mission.json")
var current_dialog_id = -1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Level 1 loaded")
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

func _on_dialog_box_ignored():
	emit_signal("close_dialog")
	emit_signal("stop_talking")
