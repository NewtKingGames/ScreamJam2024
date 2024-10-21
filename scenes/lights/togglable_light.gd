class_name TogglableLight
extends PointLight2D

@onready var turn_on_sound: AudioStreamPlayer2D = $TurnOnSound
@onready var turn_off_sound: AudioStreamPlayer2D = $TurnOffSound


func turn_on():
	toggle_light(true)
	
func turn_off():
	toggle_light(false)

func toggle_light(on: bool):
	if on:
		turn_on_sound.play()
	else:
		turn_off_sound.play()
	enabled = on
	# TODO play sound effect
	
