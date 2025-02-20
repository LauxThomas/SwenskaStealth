extends CanvasLayer

signal box_ignored #Notifies other nodes if dialog box was ignored
@onready var dialog_box =  $Control/Box
var mouse_position: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dialog_box.hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		mouse_position = dialog_box.get_global_mouse_position()
		if dialog_box.visible and not dialog_box.get_global_rect().has_point(mouse_position):
			dialog_box.hide()
			emit_signal("box_ignored")

func _on_mentor_character_talking():
	dialog_box.show()
