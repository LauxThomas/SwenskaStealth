extends CanvasLayer

signal box_closed #Notifies other nodes (like player, so it can continue moving)
signal continue_button_pressed #Notifies other nodes (like level controller, so level decides next dialogue)"
@onready var dialog_box =  $Control/Box
@onready var dialog_box_message = $Control/Box/MarginContainer/Text
@onready var dialog_box_continue_button =  $Control/Box/ContinueButton
var mouse_position: Vector2
var click_count = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dialog_box.hide()
	dialog_box_continue_button.connect("gui_input", _on_continue_button_interaction)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		mouse_position = dialog_box.get_global_mouse_position()
		if dialog_box.visible and not dialog_box.get_global_rect().has_point(mouse_position):
			dialog_box.hide()
			emit_signal("box_closed")

func _on_mentor_character_talking():
	dialog_box.show()

#This is temporal solution because the pressed signal of the button is not being tiggered
func _on_continue_button_interaction(event):
	if event is InputEventMouseButton:
		click_count += 1
		if click_count == 2:
			emit_signal("continue_button_pressed")
			click_count = 0

func _on_level_0_intro_update_dialog(dialog):
	dialog_box_message.text = dialog.message
	dialog_box_continue_button.text = dialog.continue_button_text
