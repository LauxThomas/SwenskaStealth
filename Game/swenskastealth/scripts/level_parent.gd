extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_level_0__intro_close_dialog() -> void:
	get_tree().change_scene_to_file("res://scenes/level-1-mushrooms-mission.tscn")
