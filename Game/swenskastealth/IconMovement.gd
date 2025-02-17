
extends Sprite2D

@export var speed: float = 200.0
var target_position: Vector2

func _ready():
	target_position = global_position

func _process(delta):
	if global_position.distance_to(target_position) > 2:
		global_position = global_position.move_toward(target_position, speed * delta)

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		target_position = get_global_mouse_position()
