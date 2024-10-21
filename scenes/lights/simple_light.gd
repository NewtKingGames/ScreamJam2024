class_name SimpleLight
extends StaticBody2D

@onready var turn_on_sound: AudioStreamPlayer2D = $TurnOnSound
@onready var turn_off_sound: AudioStreamPlayer2D = $TurnOffSound
@onready var light_area: LightArea = $LightArea

const alarm_color: Color = Color(0.938, 0.639, 0.275)
@export var idle_color: Color = Color.WHITE

@onready var point_light_2d: PointLight2D = $PointLight2D
var tween: Tween

func _ready() -> void:
	tween = create_tween().set_loops()
	
#
#func on() -> void:
	#point_light_2d.visible = true
#
#func off() -> void:
	#point_light_2d.visible = false

func turn_on():
	if point_light_2d.enabled:
		return
	toggle_light(true)
	
func turn_off():
	if not point_light_2d.enabled:
		return
	toggle_light(false)

func toggle_light(on: bool):
	if on:
		turn_on_sound.play()
	else:
		turn_off_sound.play()
	point_light_2d.enabled = on
	light_area.is_active = on

func alarm() -> void:
	point_light_2d.color = alarm_color
	tween.tween_property(point_light_2d, "energy", 0.0, .5)
	tween.tween_property(point_light_2d, "energy", 7.5, .5)

func stop_alarm() -> void: 
	tween.kill()
	tween = create_tween()
	point_light_2d.color = idle_color
	tween.tween_property(point_light_2d, "energy", 0, 0.1)
	tween.tween_property(point_light_2d, "energy", 7.0, 3)
