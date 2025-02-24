extends CanvasLayer

signal box_closed #Notifies other nodes if dialog box was closed
@onready var dialog_box =  $Control/Box
@onready var dialog_box_message = $Control/Box/Text
@onready var dialog_box_button =  $Control/Box/Button
var mouse_position: Vector2
var click_count = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dialog_box.hide()
	dialog_box_button.connect("gui_input", _on_button_interaction)

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
func _on_button_interaction(event):
	if event is InputEventMouseButton:
		click_count += 1
		print("click on button")
		print(click_count)
		if click_count == 2:
			print("signal to get new dialogue")
			dialog_box_message.text = "algo nuevo"
			click_count = 0
