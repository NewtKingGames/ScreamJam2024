class_name Walking
extends PlayerState

func enter() -> void:
	print("entering")

func exit() -> void:
	print("exiting")

func process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	player.velocity = direction * 200
