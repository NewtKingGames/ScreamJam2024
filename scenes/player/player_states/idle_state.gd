class_name IdleState
extends PlayerState

func exit() -> void:
	print("exiting state")

func enter() -> void:
	print("entering state")


func process(delta: float) -> void:
	print("idle process")
	if Input.get_vector("down","up","right","left"):
		transition_requested.emit(self, State.WALKING)
