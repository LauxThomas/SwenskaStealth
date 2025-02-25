extends TextureButton

@onready var dictionary_panel = get_parent().get_node("DictionaryPanel")
var dictionary_label

# Example dictionary entries
var dictionary_entries = ["Apple: A fruit", "Book: A source of knowledge"]

func _ready():
	# Initialize dictionary_label after dictionary_panel is ready
	if dictionary_panel:
		dictionary_label = dictionary_panel.get_node("DictionaryLabel")
		dictionary_panel.visible = false
	else:
		push_error("DictionaryPanel not found. Check node paths.")

func _pressed():
	# Toggle the visibility of the dictionary panel
	if dictionary_panel:
		dictionary_panel.visible = not dictionary_panel.visible

		if dictionary_panel.visible:
			update_dictionary_text()

func update_dictionary_text():
	# Join dictionary entries into a single string
	var text = "Dictionary Entries:\n\n"
	text += "\n".join(dictionary_entries)
	if dictionary_label:
		dictionary_label.text = text

# Function to add new entries dynamically
func add_new_entry(word: String, definition: String):
	dictionary_entries.append("%s: %s" % [word, definition])
	update_dictionary_text()
