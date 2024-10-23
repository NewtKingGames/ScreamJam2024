extends EnemyState
class_name EnemyChasing
const MONSTER_GROWL = preload("res://sounds/monster_growl.mp3")
const GASP_AFTER_SCARE = preload("res://sounds/gasp-after-scare.mp3")
var time_in_chase: float = 0.0
func enter() -> void:
	time_in_chase = 0.0
	SfxPlayer.play(MONSTER_GROWL)
	enemy.footstep_audio_player.volume_db = enemy.starting_volume
	enemy.footstep_audio_player.play()

func exit() -> void:
	enemy.footstep_audio_player.stop()
	enemy.position = enemy.starting_position
	SfxPlayer.play(GASP_AFTER_SCARE)

func process(delta: float) -> void:
	if not enemy.is_chasing_player:
		transition_requested.emit(self, State.IDLE)
		return
	time_in_chase += delta
	enemy.footstep_audio_player.volume_db = clampf(enemy.starting_volume + 35*enemy.starting_volume*(time_in_chase/enemy.chase_time), 0, 17)
	enemy.velocity = enemy.chase_speed * enemy.global_position.direction_to(enemy.player.global_position)
	enemy.calculate_chase_speed(enemy.chase_time - time_in_chase)
	if time_in_chase >= enemy.chase_time:
		print("player died")
		# TODO fix this exit chase thing
		enemy.exit_chase()
