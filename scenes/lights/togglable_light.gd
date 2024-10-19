class_name TogglableLight
extends PointLight2D


func turn_on():
	toggle_light(true)
	
func turn_off():
	toggle_light(false)

func toggle_light(on: bool):
	enabled = on
	# TODO play sound effect
	
