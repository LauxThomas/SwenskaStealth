extends Area2D

@export var dialogue_ui: Node  # Assign this in the Inspector
@export var mentor: Area2D  
@export var mentor_speed: float = 100.0  # Adjust speed in the Inspector

@export var animated_sprite: AnimatedSprite2D  # The AnimatedSprite2D for the NPC
@export var animation_up: String = "up"
@export var animation_down: String = "down"
@export var animation_left: String = "left"
@export var animation_right: String = "right"

@export var player = Node  # Store reference to the player

func _ready():
	dialogue_ui.visible = false  # Hide dialogue at start
	connect("area_entered", _on_area_entered)
	connect("area_exited", _on_area_exited)
	print("Loaded")

func _move_towards_player():
	if player and mentor :
		var direction = player.global_position - mentor.global_position
		if direction.length() > 0:
			# Normalize direction to prevent fast diagonal movement
			direction = direction.normalized()
			_update_animation(direction)

func _on_area_entered(body):
	print("Entered:", body.name)  # Debugging message
	if body.is_in_group("player"):
		print("Player detected! Showing dialogue.")
		_move_towards_player()
		dialogue_ui.visible = true  # Show dialogue

func _on_area_exited(body):
	print("Exited:", body.name)  # Debugging message
	if body.is_in_group("player"):
		print("Player left! Hiding dialogue.")
		dialogue_ui.visible = false  # Hide dialogue
		
# Function to update NPC's animation based on movement direction
func _update_animation(direction: Vector2):
	if abs(direction.x) > abs(direction.y):
		# Moving left or right
		if direction.x > 0:
			animated_sprite.play(animation_right)  # Right animation
		else:
			animated_sprite.play(animation_left)  # Left animation
	else:
		# Moving up or down
		if direction.y > 0:
			animated_sprite.play(animation_down)  # Down animation
		else:
			animated_sprite.play(animation_up)  # Up animation
