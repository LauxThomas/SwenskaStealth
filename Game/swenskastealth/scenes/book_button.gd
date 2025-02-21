extends TextureButton

func _ready():
	print("Book Icon Ready!")

func _pressed():
	print("Book Icon Clicked!")
	# Example: Toggle a dictionary panel
	# get_node("/root/Main/DictionaryPanel").visible = true
