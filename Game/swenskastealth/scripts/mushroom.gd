extends Area2D

signal collected

@export var value: int = 1  # How many mushrooms this gives
@export var mushroom_type: String = "TODO: CHANGE"  # Change this per mushroom instance
@onready var audio_player = $AudioStreamPlayer  # Reference the AudioStreamPlayer node
@export var mushroom_audio: String = "TODO: CHANGE"

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.name == "Raccoon": # Thats the Player
		body.collect_mushroom(value, mushroom_type)  # Pass the mushroom type
		audio_player.autoplay(mushroom_audio)
		queue_free()  # Remove the mushroom from the scene
