class_name ArrowInteractable
extends Interactable

enum ArrowInputType {UP, DOWN, LEFT, RIGHT}

@export var arrow_inputs: Array[ArrowInputType] = []
var current_index = 0

# -1 indicates the input was incorrect or that the
func handle_input(event: InputEvent) -> int:
	if current_index == arrow_inputs.size():
		return -1
	var next_arrow_input: ArrowInputType = arrow_inputs[current_index] 
	if does_input_match(event, next_arrow_input):
		var index_to_return = current_index
		current_index += 1
		return index_to_return
	return -1

func does_input_match(event: InputEvent, arrow: ArrowInputType) -> bool:     
	if event.is_action_pressed("left") and arrow == ArrowInputType.LEFT:
		return true 
	if event.is_action_pressed("right") and arrow == ArrowInputType.RIGHT:
		return true
	if event.is_action_pressed("up") and arrow == ArrowInputType.UP:
		return true
	if event.is_action_pressed("down") and arrow == ArrowInputType.DOWN:
		return true
	return false
