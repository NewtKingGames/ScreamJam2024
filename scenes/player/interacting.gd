extends PlayerState


func enter():
	pass

func exit():
	pass


func process(delta: float) -> void:
	if not player.interactable_near:
		print("something went wrong!!!")
		transition_requested.emit(self. State.IDLE)
		return
	if Input.is_action_just_pressed("exit"):
		player.interactable_near.player_exit_interaction()
		transition_requested.emit(self. State.IDLE)
	
