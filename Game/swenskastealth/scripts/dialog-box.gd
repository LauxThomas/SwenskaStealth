extends Panel
signal click_outside
var mouse_position: Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		mouse_position = get_global_mouse_position()
		if visible and not get_global_rect().has_point(mouse_position):
			emit_signal("click_outside")
			hide()

func _on_talk_button_pressed():
	print("talk button pressed")
	show()
