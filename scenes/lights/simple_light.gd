class_name SimpleLight
extends StaticBody2D


const alarm_color: Color = Color(0.938, 0.639, 0.275)
@export var idle_color: Color = Color.WHITE

@onready var point_light_2d: PointLight2D = $PointLight2D
var tween: Tween

func _ready() -> void:
	tween = create_tween().set_loops()
	

func on() -> void:
	point_light_2d.visible = true

func off() -> void:
	point_light_2d.visible = false

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
