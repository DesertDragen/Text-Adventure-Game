extends Node


signal response_generated(response_text)

var current_room = null


func initilize(starting_room):
	current_room = starting_room


func process_command(input: String) -> String:
	# Split the words at the space and do it only once
	var words = input.split(" ", false)
	if words.size() == 0:
		return "Error: no words were parsed."
	
	var first_word = words[0].to_lower()
	var second_word = ""
	if words.size() > 1:
		second_word = words[1].to_lower()
		
	# match == switch case
	match first_word:
		"help":
			return help()
		"go":
			return go(second_word)
		_: # _: == default
			return "Unrecognized command - please try again."	
			

# -> String = Returns a value of a String
func go(second_word: String) -> String:
	if second_word == "":
		return "Go where?"
	
	# Can do "%s %s" % [word_one, word_two...]	
	return "You go %s" % second_word


func help() -> String:
	return "You can use these commands: help, go [location]"
