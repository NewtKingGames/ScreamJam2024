class_name ButtonPromptInteractable
extends Interactable


@export var messages: Array[String] 
var message_index: int = 0

func handle_press() -> int:
	if message_index == messages.size()-1:
		completed_input()
		return -1
	else:
		message_index+=1
		return message_index
