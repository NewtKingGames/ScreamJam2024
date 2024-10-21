extends EnemyState
class_name EnemyIdle

func process(delta: float) -> void:
	if enemy.is_chasing_player:
		transition_requested.emit(self, State.STARTING)
