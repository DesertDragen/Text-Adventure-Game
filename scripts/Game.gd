extends Control

# Storing the data of the InputResponse scene
const InputResponse = preload("res://scenes/InputResponse.tscn")

var max_scroll_length := 0

# Only use $ to access the children of the nodes
onready var history_rows = $Background/MarginContainer/Rows/GameInfo/Scroll/HistoryRows
onready var scroll = $Background/MarginContainer/Rows/GameInfo/Scroll
onready var scrollbar = scroll.get_v_scrollbar()


func _ready() -> void:
	scrollbar.connect("changed", self, "handle_scrollbar_changed")
	# Set a max baseline for the scroll length
	max_scroll_length = scrollbar.max_value
	

# Only scroll down when the max value of the scrollbar changes
func handle_scrollbar_changed():
	if max_scroll_length != scrollbar.max_value:
		max_scroll_length = scrollbar.max_value
		scroll.scroll_vertical = max_scroll_length


# 
func _on_Input_text_entered(new_text: String) -> void:
	# Return nothing if the user enters nothing
	if new_text.empty():
		return
		
	# Creating an instance of the InputResponse scene
	var input_response = InputResponse.instance()
	# Sending the new_text to the function in InputResponse script
	input_response.set_text(new_text, "This is where a repsonse would go")
	# Adding the instance of the scene as a child of the history_rows node
	history_rows.add_child(input_response)
