class_name TogglableLight
extends PointLight2D

@onready var turn_on_sound: AudioStreamPlayer2D = $TurnOnSound
@onready var turn_off_sound: AudioStreamPlayer2D = $TurnOffSound
@onready var light_area: LightArea = $LightArea


func turn_on():
	if enabled:
		return
	toggle_light(true)
	
func turn_off():
	if not enabled:
		return
	toggle_light(false)

func toggle_light(on: bool):
	if on:
		turn_on_sound.play()
	else:
		turn_off_sound.play()
	enabled = on
	light_area.is_active = on
