extends CharacterBody2D

@export var speed: float = 200.0
signal player_position_updated  # Notifies other nodes interested in player position

var target_position: Vector2
var moving_horizontally = true  
var talking = false  
var moving = false  

# Dictionary to track different types of mushrooms
var mushrooms_collected = {
	"yellow": 0,
	"red": 0,
	"purple": 0
}

# Required mushroom counts
const REQUIRED_MUSHROOMS = {
	"yellow": 10,
	"purple": 7,
	"red": 4
}

@onready var sprite = $Sprite2D
@onready var target_marker = get_parent().find_child("TargetMarker")  

@onready var toolbar = get_tree().get_first_node_in_group("toolbar")  # Get the toolbar scene

func _ready():
	print("Player initialized. Mushrooms collected: ", mushrooms_collected)
	_stop_movement()
	if target_marker:
		target_marker.hide()  # Initially hide the marker

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if talking:
			return

		target_position = get_global_mouse_position()
		moving_horizontally = true  
		moving = true  

		if target_marker:
			target_marker.global_position = target_position
			target_marker.show()

func _physics_process(delta):  # ✅ Use _physics_process for collision handling
	if moving:  
		_move_to_click_position(delta)

func _move_to_click_position(delta):
	if global_position.distance_to(target_position) > 2 and not talking:
		var direction = get_four_direction_vector(target_position - global_position)
		velocity = direction * speed  # ✅ Use velocity instead of directly changing position
		move_and_slide()  # ✅ This ensures collision is respected
		update_animation(direction)
		emit_signal("player_position_updated", global_position)
	else:
		stop_animation()
		moving = false  
		if target_marker:
			target_marker.hide()

func get_four_direction_vector(delta_pos: Vector2) -> Vector2:
	if moving_horizontally:
		if abs(delta_pos.x) > 2:
			return Vector2.RIGHT if delta_pos.x > 0 else Vector2.LEFT
		else:
			moving_horizontally = false  
	if not moving_horizontally:
		if abs(delta_pos.y) > 2:
			return Vector2.DOWN if delta_pos.y > 0 else Vector2.UP
	
	return Vector2.ZERO  

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
	moving = false  

func _on_mentor_character_talking():
	talking = true
	_stop_movement()

func _on_level_0__intro_start_dialog():
	talking = true
	_stop_movement()

func _on_level_1__mushrooms_mission_stop_talking():
	talking = false
	
func collect_mushroom(amount: int, color: String):
	if color in mushrooms_collected:
		mushrooms_collected[color] += amount
		print(color.capitalize(), "Mushroom collected! Total:", mushrooms_collected[color])

		# Update the UI through the toolbar scene
		if toolbar:
			toolbar._on_update_mushrooms_counter(color, mushrooms_collected[color])
		else:
			print("❌ Toolbar not found! Ensure the toolbar scene is added to the scene tree.")

	else:
		print("❌ Unknown mushroom type:", color)
		
func check_all_mushrooms_collected() -> bool:
	for mushroom in REQUIRED_MUSHROOMS.keys():
		if mushrooms_collected[mushroom] < REQUIRED_MUSHROOMS[mushroom]:
			return false  # Missing mushrooms
	return true  # All required mushrooms are collected
