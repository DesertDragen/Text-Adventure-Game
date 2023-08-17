extends VBoxContainer


# Setting the text for the label
func set_text(input: String, response: String):
	$InputHistroy.text = " > " + input
	$Response.text = response
