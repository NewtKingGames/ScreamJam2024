class_name Interacting
extends PlayerState

func process(delta: float) -> void:
	if not player.interactable_near:
		transition_requested.emit(self. State.IDLE)
		return
	if Input.is_action_just_pressed("exit"):
		player.interactable_near.player_exit_interaction()
		transition_requested.emit(self, State.IDLE)
	
