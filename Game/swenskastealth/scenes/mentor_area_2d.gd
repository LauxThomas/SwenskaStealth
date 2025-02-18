extends Area2D

@export var dialogue_ui: Node  # Assign this in the Inspector

func _ready():
	dialogue_ui.visible = false  # Hide dialogue at start
	connect("area_entered", _on_area_entered)
	connect("area_exited", _on_area_exited)
	print("Loaded")

func _on_area_entered(body):
	print("Entered:", body.name)  # Debugging message
	if body.is_in_group("player"):
		print("Player detected! Showing dialogue.")
		dialogue_ui.visible = true  # Show dialogue

func _on_area_exited(body):
	print("Exited:", body.name)  # Debugging message
	if body.is_in_group("player"):
		print("Player left! Hiding dialogue.")
		dialogue_ui.visible = false  # Hide dialogue
