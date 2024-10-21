class_name HallWayLightsFlash
extends Node2D

@onready var lights: Node2D = $Lights

enum LightPattern{STATIC, IN_ORDER, BACK_FORTH}

@export var pattern: LightPattern = LightPattern.STATIC
@export var light_on_duration: float = 5
@export var delay_until_next_light: float = 4.5
var are_lights_powered: bool = true
var are_lights_flashing: bool = true


func _ready() -> void:
	toggle_all_lights(are_lights_powered)
	start_light_pattern()

func toggle_all_lights(on: bool) -> void:
	for light in lights.get_children():
		if light is SimpleLight:
			if on:
				light.turn_on()
			else:
				light.turn_off()

func start_light_pattern() -> void:
	#var tween = create_tween().set_loops()
	while true:
		print("word!")
	
