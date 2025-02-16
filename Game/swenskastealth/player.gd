#Good chat-GPT code

#changes:
# 16/02 Lina: I have added the background and the racoon (including collitionshape2D) and the camera2D


extends Node2D

# Speed of movement in pixels per second
@export var speed: float = 200.0

func _process(delta: float) -> void:
	# Create a vector for movement input
	var input_vector = Vector2.ZERO

	# Capture WASD input
	if Input.is_action_pressed("ui_up"):
		input_vector.y -= 1
	if Input.is_action_pressed("ui_down"):
		input_vector.y += 1
	if Input.is_action_pressed("ui_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1

	# Normalize to avoid diagonal speed increase, then apply speed
	input_vector = input_vector.normalized() * speed * delta

	# Move the node
	position += input_vector
