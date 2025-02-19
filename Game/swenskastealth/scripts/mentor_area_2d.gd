extends Area2D

@export var dialog_box: Panel  # Assign this in the Inspector
@export var talk_button: TextureButton # Drag the "talk" icon (TextureRect)
@export var animated_sprite: AnimatedSprite2D  # The AnimatedSprite2D for the mentor
@export var player = CharacterBody2D  # Store reference to the player

func _ready():
	talk_button.visible = false
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)
	talk_button.connect("gui_input", _on_talk_button_clicked)

func _on_body_entered(body):
	if body.is_in_group("player"):
		talk_button.visible = true

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

func _on_talk_button_clicked(event):
	if event is InputEventMouseButton and event.pressed:
		_move_towards_player()

func _clear_controls():
	dialog_box.visible = false
	talk_button.visible = false

func _move_towards_player():
	if player:
		var direction = player.global_position - global_position
		if direction.length() > 0:
			# Normalize direction to prevent fast diagonal movement
			direction = direction.normalized()
			_update_animation(direction)
