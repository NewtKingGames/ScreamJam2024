class_name DarknessEnemy
extends CharacterBody2D

var player: Player

const chase_time: float = 10.0
var time_in_chase: float = 0.0
var is_chasing_player: bool = false
var starting_position: Vector2
var chase_speed: float
# TODO - fix the loop in this clip. The difference between the start and end isn't enough time
@onready var footstep_audio_player: AudioStreamPlayer2D = $FootstepAudioPlayer
@onready var starting_volume: float = footstep_audio_player.volume_db

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	Events.player_entered_darkness.connect(_on_player_entered_darkness)
	Events.player_exited_darkness.connect(_on_player_exited_darkness)
	starting_position = position
	
func _process(delta: float) -> void:
	if is_chasing_player:
		# increase the sound of the foot steps
		# TODO - tweak this, maybe use a tween?
		footstep_audio_player.volume_db = clampf(starting_volume + 30*starting_volume*(time_in_chase/chase_time), 0, 17)
		time_in_chase += delta
		velocity = chase_speed * global_position.direction_to(player.global_position)
		calculate_chase_speed(chase_time - time_in_chase)
		if time_in_chase >= chase_time:
			print("player died")
			exit_chase()
		move_and_slide()
		
# TODO - add some kind of delay before the chase starts and add some visual/audio queue that the player walked into the dark
func _on_player_entered_darkness() -> void:
	enter_chase()

func _on_player_exited_darkness() -> void:
	exit_chase()

func enter_chase() -> void:
	is_chasing_player = true
	# Calculate chase velocity, the chase velocity is equal to the distance_to_player/chase_time
	calculate_chase_speed(chase_time)
	footstep_audio_player.volume_db = starting_volume
	footstep_audio_player.play()

func exit_chase() -> void:
	is_chasing_player = false
	position = starting_position
	time_in_chase = 0.0
	footstep_audio_player.stop()

func calculate_chase_speed(time_left: float) -> void:
	chase_speed = player.global_position.distance_to(global_position) / time_left
