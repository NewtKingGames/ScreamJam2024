class_name Walking
extends PlayerState
 

func process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	player.velocity = direction * 400
	if not direction:
		transition_requested.emit(self, State.IDLE)	
