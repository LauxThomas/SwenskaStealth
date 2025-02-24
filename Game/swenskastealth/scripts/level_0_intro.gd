extends Node2D

signal update_dialog(dialog)
@onready var dialogs = _load_json("res://dialogs/level-0-intro.json")
var current_dialog_id = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if dialogs.is_empty():
		print("failed to load dialogs")
		return
	emit_signal("update_dialog", dialogs[current_dialog_id])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_dialog_continue_button_pressed():
	current_dialog_id += 1
	print(dialogs[current_dialog_id])
	emit_signal("update_dialog", dialogs[current_dialog_id])

func _load_json(path):
	var file = FileAccess.open(path, FileAccess.READ)
	if file:
		var content = file.get_as_text()
		return JSON.parse_string(content) if JSON.parse_string(content) else {}
	return {}
