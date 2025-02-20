extends Node2D

signal character_talking
#NPC = Non Player Character
@onready var npc_area =  $Area2D
@onready var npc_sprite = $Area2D/AnimatedSprite2D
@onready var talk_button = $Area2D/Control/TalkButton

 # variable to track position of main character or player
var player_position: Vector2

func _ready():
	talk_button.visible = false
	npc_area.connect("body_entered", _on_body_entered)
	npc_area.connect("body_exited", _on_body_exited)
	talk_button.connect("gui_input", _on_talk_button_clicked)

func _on_body_entered(body):
	if body.is_in_group("player"):
		talk_button.show()

func _on_body_exited(body):
	if body.is_in_group("player"):
		talk_button.hide()

func _on_talk_button_clicked(event):
	if event is InputEventMouseButton and event.pressed:
		_move_towards_player()
		emit_signal("character_talking")

func _on_raccoon_player_position_updated(position):
	player_position =  position

func _move_towards_player():
	var direction = player_position - global_position
	if direction.length() > 0:
		# Normalize direction to prevent fast diagonal movement
		direction = direction.normalized()
		_update_animation(direction)

# Function to update mentors animation based on movement direction
func _update_animation(direction: Vector2):
	if abs(direction.x) > abs(direction.y):
		# Moving left or right
		if direction.x > 0:
			npc_sprite.play("right")  # Right animation
		else:
			npc_sprite.play("left")  # Left animation
	else:
		# Moving up or down
		if direction.y > 0:
			npc_sprite.play("down")  # Down animation
		else:
			npc_sprite.play("up")  # Up animation
