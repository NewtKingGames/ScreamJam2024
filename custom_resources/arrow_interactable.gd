class_name ArrowInteractable
extends Interactable

enum ArrowInputType {UP, DOWN, LEFT, RIGHT}

@export var arrow_inputs: Array[ArrowInputType] = []


func handle_input(event: InputEvent) -> bool:
	if arrow_inputs.size() == 0:
		return false
	var next_arrow_input: ArrowInputType = arrow_inputs[arrow_inputs.size()-1] 
	if does_input_match(event, next_arrow_input):
		arrow_inputs.pop_back()
		return true
	return false

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
