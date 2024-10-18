class_name IdleState
extends PlayerState


func process(delta: float) -> void:
	if Input.get_vector("down","up","right","left"):
		transition_requested.emit(self, State.WALKING)
	if Input.is_action_just_pressed("interact") and player.interactable_near:
		player.interactable_near.player_interacted()
		transition_requested.emit(self, State.INTERACTING)
		
