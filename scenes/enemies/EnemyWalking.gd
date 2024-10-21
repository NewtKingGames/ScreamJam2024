extends EnemyState
class_name EnemyStarting

var current_time: float = 0

func enter() -> void:
	current_time = 0
	
func exit() -> void:
	pass
	
func process(delta: float) -> void:
	if not enemy.is_chasing_player:
		transition_requested.emit(self, State.IDLE)
	else:
		current_time += delta
		if current_time >= enemy.time_to_chase:
			transition_requested.emit(self, State.CHASING)
