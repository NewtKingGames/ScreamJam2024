class_name Walking
extends PlayerState
 
var foot_step_sound_delay: float = 0.45
var elapsed_time: float = 0.0

func enter() -> void:
	elapsed_time =0
	# TODO - this is a little gross because it means the player can make a ton of walk noises
	#player.play_walk_sound()

func process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	player.velocity = direction * 400
	if not direction:
		transition_requested.emit(self, State.IDLE)	
	elapsed_time += delta
	if elapsed_time >= foot_step_sound_delay:
		elapsed_time = 0.0
		player.play_walk_sound()
