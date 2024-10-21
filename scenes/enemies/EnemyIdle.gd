extends EnemyState
class_name EnemyIdle


func enter() -> void:
	print("monster in idle state")


func process(delta: float) -> void:
	if enemy.is_chasing_player:
		transition_requested.emit(self, State.STARTING)
