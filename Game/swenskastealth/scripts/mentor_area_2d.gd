extends Area2D

@export var dialogue_ui: Node  # Assign this in the Inspector
@export var talk_icon: TextureButton # Drag the "talk" icon (TextureRect)
@export var mentor: Area2D
@export var animated_sprite: AnimatedSprite2D  # The AnimatedSprite2D for the mentor
@export var player = CharacterBody2D  # Store reference to the player

func _ready():
	_clear_controls()
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)
	talk_icon.connect("gui_input", _on_talk_icon_clicked)

func _on_body_entered(body):
	if body.is_in_group("player"):
		talk_icon.visible = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		_clear_controls()

# Function to update mentors animation based on movement direction
func _update_animation(direction: Vector2):
	if abs(direction.x) > abs(direction.y):
		# Moving left or right
		if direction.x > 0:
			animated_sprite.play("right")  # Right animation
		else:
			animated_sprite.play("left")  # Left animation
	else:
		# Moving up or down
		if direction.y > 0:
			animated_sprite.play("down")  # Down animation
		else:
			animated_sprite.play("up")  # Up animation

func _on_talk_icon_clicked(event):
	if event is InputEventMouseButton and event.pressed:
		_move_towards_player()
		dialogue_ui.visible = true  # Show dialogue when clicking the talk icon

func _clear_controls():
	dialogue_ui.visible = false
	talk_icon.visible = false

func _move_towards_player():
	if player and mentor :
		var direction = player.global_position - mentor.global_position
		if direction.length() > 0:
			# Normalize direction to prevent fast diagonal movement
			direction = direction.normalized()
			_update_animation(direction)
