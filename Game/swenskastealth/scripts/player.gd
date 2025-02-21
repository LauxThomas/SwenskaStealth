extends Node2D

@export var speed: float = 200.0
signal player_position_updated  # Notifies other nodes interested in player position

var target_position: Vector2
var moving_horizontally = true  # Control horizontal/vertical priority
var talking = false  # Indicates if the player is talking or not
var moving = false  # 🚀 New flag to control movement state

@onready var sprite = $CharacterBody2D/Sprite2D
@onready var target_marker = get_parent().find_child("TargetMarker")  # Finds the marker in the scene

func _ready():
	_stop_movement()
	if target_marker:
		target_marker.hide()  # Initially hide the marker

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if talking:
			return

		target_position = get_global_mouse_position()
		moving_horizontally = true  # Reset movement priority
		moving = true  # 🚀 Start movement

		# Move marker to the target position and show it
		if target_marker:
			target_marker.global_position = target_position
			target_marker.show()

func _process(delta):
	if moving:  # 🚀 Move only when necessary
		_move_to_click_position(delta)

func _move_to_click_position(delta):
	if global_position.distance_to(target_position) > 2 and not talking:
		var direction = get_four_direction_vector(target_position - global_position)
		global_position += direction * speed * delta  # Move only in one direction
		update_animation(direction)
		emit_signal("player_position_updated", global_position)
	else:
		stop_animation()
		moving = false  # 🚀 Stop movement
		if target_marker:
			target_marker.hide()

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

func _stop_movement():
	target_position = global_position
	moving = false  # 🚀 Ensure movement stops

func _on_mentor_character_talking():
	talking = true
	_stop_movement()  # 🚀 Stop movement when talking

func _on_dialog_box_ignored():
	talking = false
	_stop_movement()
