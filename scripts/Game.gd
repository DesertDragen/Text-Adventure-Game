extends Control

# Storing the data of the InputResponse scene
const InputResponse = preload("res://scenes/InputResponse.tscn")
const Response = preload("res://scenes/Response.tscn")

# This value can be edited in the editor
export (int) var max_lines_remembered := 30

var max_scroll_length := 0

# Use $ to access the children of the nodes or another script
onready var command_processor = $CommandProcessor
onready var history_rows = $Background/MarginContainer/Rows/GameInfo/Scroll/HistoryRows
onready var scroll = $Background/MarginContainer/Rows/GameInfo/Scroll
onready var scrollbar = scroll.get_v_scrollbar()
onready var room_manager = $RoomManager


func _ready() -> void:
	scrollbar.connect("changed", self, "handle_scrollbar_changed")
	# Set a max baseline for the scroll length
	max_scroll_length = scrollbar.max_value
	
	handle_response_generated("Welcome to the Retro Text Adventure! You can type 'help' to see available commands.")
	
	# Connect this first so that the player gets the message first
	command_processor.connect("response_generated", self, "handle_response_generated")
	# Initializes the game and prints out the new room message
	command_processor.initilize(room_manager.get_child(0))
	

# Only scroll down when the max value of the scrollbar changes
func handle_scrollbar_changed():
	if max_scroll_length != scrollbar.max_value:
		max_scroll_length = scrollbar.max_value
		scroll.scroll_vertical = max_scroll_length


func _on_Input_text_entered(new_text: String) -> void:
	# Return nothing if the user enters nothing
	if new_text.empty():
		return
		
	# Creating an instance of the InputResponse scene
	var input_response = InputResponse.instance()
	var response = command_processor.process_command(new_text)
	# Sending the new_text to the function in InputResponse script
	input_response.set_text(new_text, response)
	
	add_response_to_game(input_response)


func handle_response_generated(response_text: String):
	# Create a new instance of Response
	var response = Response.instance()
	response.text = response_text
	add_response_to_game(response)


func add_response_to_game(response: Control):
	# Adding the instance of the scene as a child of the history_rows node
	history_rows.add_child(response)
	delete_history_beyond_limit()


func delete_history_beyond_limit():
	# Return the number of children in HistoryRows and delete the earlier lines
	if history_rows.get_child_count() > max_lines_remembered:
		# Subtract the max lines remembered from the number of rows from HistoryRows
		var rows_to_forget = history_rows.get_child_count() - max_lines_remembered
		# Loop through an array to forget one line
		for i in range(rows_to_forget):
			# queue_free deletes from the tree and from memory (deletes as soon as its safe to do so)
			history_rows.get_child(i).queue_free()


