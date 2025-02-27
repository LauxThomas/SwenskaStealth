extends CanvasLayer

@onready var dictionary = $Control/Dictionary
@onready var mushrooms =  $Control/MushroomsCounter
@onready var brown_mushrooms_counter =  $Control/MushroomsCounter/BrownMushroomCounter
@onready var red_mushrooms_counter = $Control/MushroomsCounter/RedWhiteMushroomCounter
@onready var purple_mushrooms_counter = $Control/MushroomsCounter/PurpleMushroomCounter


func _ready() -> void:
	dictionary.hide()
	mushrooms.hide()

func _on_show_dictionary():
	dictionary.show()

func _on_show_mushrooms() -> void:
	mushrooms.show()

func _on_update_mushrooms_counter(color, integer_value):
	if integer_value and integer_value > 0:
		var new_value = str(integer_value)
		match color:
			"brown": brown_mushrooms_counter.text =  new_value
			"red": red_mushrooms_counter.text = new_value
			"purple": purple_mushrooms_counter.text = new_value
