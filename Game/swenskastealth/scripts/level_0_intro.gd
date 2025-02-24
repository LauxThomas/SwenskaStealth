extends Node2D

signal update_dialog(dialog)

var dialog = {
	"message": null,
	"continue_button_text": null,
	"secondary_button_text": null
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dialog.message = "Hej, you’re finally awake.  Välkommen till Sverige."
	dialog.continue_button_text = "Sverige?"
	dialog.secondary_button_text = null
	emit_signal("update_dialog", dialog)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_dialog_continue_button_pressed():
	_get_next_dialog()
	print(dialog)
	emit_signal("update_dialog", dialog)

func _get_next_dialog():
	dialog.message = "Ja, välkommen till Sverige.  Welcome to Sweden!  Are you ready?"
	dialog.continue_button_text = "I am ready"
	dialog.secondary_button_text = "Ready for what?"
