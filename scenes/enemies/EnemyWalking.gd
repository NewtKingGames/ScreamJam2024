extends EnemyState
class_name EnemyStarting


var time_to_chase: float = 1.5
var current_time: float = 0


func enter() -> void:
	current_time = 0
	print("monster in start up state")
	
func exit() -> void:
	pass
	
func process(delta: float) -> void:
	if not enemy.is_chasing_player:
		transition_requested.emit(self, State.IDLE)
	else:
		current_time += delta
		print(current_time)
		if current_time >= time_to_chase:
			transition_requested.emit(self, State.CHASING)
