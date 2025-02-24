extends Node2D

signal update_dialog(dialog)
@onready var dialogs = _load_json("res://dialogs/level-0-intro.json")
var current_dialog_id = -1
var current_dialog = null
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
		print(dialogs[current_dialog_id])
		emit_signal("update_dialog", dialogs[current_dialog_id])

func _on_dialog_continue_button_pressed():
	_get_next_dialog()

func _load_json(path):
	var file = FileAccess.open(path, FileAccess.READ)
	if file:
		var content = file.get_as_text()
		return JSON.parse_string(content) if JSON.parse_string(content) else {}
	return {}
