extends Area2D


# TODO - this should start some music
@onready var end_level_tense_music: AudioStreamPlayer = $"../EndLevelTenseMusic"
@onready var hallway_lights_flash: HallWayLightsFlash = $"../HallwayLightsFlash"

var one_shot: bool = true

func _ready() -> void:
	body_entered.connect(_on_player_entered)
	
func _on_player_entered(body: Node2D) -> void:
	if one_shot:
		one_shot = false
		end_level_tense_music.play()
		hallway_lights_flash.start_light_pattern()
