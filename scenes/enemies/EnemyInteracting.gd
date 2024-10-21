extends EnemyState
class_name EnemyChasing


const chase_time: float = 10.0
var time_in_chase: float = 0.0

func enter() -> void:
	enemy.footstep_audio_player.volume_db = enemy.starting_volume
	enemy.footstep_audio_player.play()

func exit() -> void:
	enemy.footstep_audio_player.stop()
	enemy.position = enemy.starting_position

func process(delta: float) -> void:
	if not enemy.is_chasing_player:
		transition_requested.emit(self, State.IDLE)
		return
	time_in_chase += delta
	enemy.footstep_audio_player.volume_db = clampf(enemy.starting_volume + 30*enemy.starting_volume*(time_in_chase/chase_time), 0, 17)
	enemy.velocity = enemy.chase_speed * enemy.global_position.direction_to(enemy.player.global_position)
	enemy.calculate_chase_speed(chase_time - time_in_chase)
	if time_in_chase >= chase_time:
		print("player died")
		# TODO fix this exit chase thing
		enemy.exit_chase()
