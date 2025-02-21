extends TextureRect



func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var mouse_pos = get_global_mouse_position()
		if get_global_rect().has_point(mouse_pos):
			print("Clicked on TextureRect!")
