extends Control

# Storing the data of the InputResponse scene
const InputResponse = preload("res://scenes/InputResponse.tscn")

# Only use $ to access the children of the nodes
onready var history_rows = $Background/MarginContainer/Rows/GameInfo/ScrollContainer/HistoryRows


func _on_Input_text_entered(new_text: String) -> void:
	# Creating an instance of the InputResponse scene
	var input_response = InputResponse.instance()
	# Adding the instance of the scene as a child of the history_rows node
	history_rows.add_child(input_response)
