extends Node2D  # Attach to Node2D

@export var speed: float = 200.0
var target_position: Vector2
var moving_horizontally = true  # Control horizontal/vertical priority

@onready var sprite = $Sprite2D  # Ensure this matches the child name

func _ready():
	if not sprite:
		print("Error: AnimatedSprite2D not found!")
	target_position = global_position

func _process(delta):
	if global_position.distance_to(target_position) > 2:
		var direction = get_four_direction_vector(target_position - global_position)
		global_position += direction * speed * delta  # Move only in one direction
		update_animation(direction)
	else:
		stop_animation()

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		target_position = get_global_mouse_position()
		moving_horizontally = true  # Reset movement priority

func get_four_direction_vector(delta_pos: Vector2) -> Vector2:
	if moving_horizontally:
		if abs(delta_pos.x) > 2:  # If horizontal movement needed
			return Vector2.RIGHT if delta_pos.x > 0 else Vector2.LEFT
		else:
			moving_horizontally = false  # Switch to vertical
	if not moving_horizontally:
		if abs(delta_pos.y) > 2:  # If vertical movement needed
			return Vector2.DOWN if delta_pos.y > 0 else Vector2.UP
	
	return Vector2.ZERO  # Stop if no movement needed

func update_animation(direction: Vector2):
	if sprite:
		if direction == Vector2.RIGHT:
			sprite.animation = "right"
		elif direction == Vector2.LEFT:
			sprite.animation = "left"
		elif direction == Vector2.DOWN:
			sprite.animation = "down"
		elif direction == Vector2.UP:
			sprite.animation = "up"
		
		sprite.play()

func stop_animation():
	if sprite:
		sprite.stop()
