extends CanvasLayer

@onready var dictionary = $Control/Dictionary
@onready var mushroom_counter =  $Control/MushroomsCounter


func _ready() -> void:
	dictionary.hide()
	mushroom_counter.hide()
