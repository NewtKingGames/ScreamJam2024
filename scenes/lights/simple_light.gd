class_name SimpleLight
extends StaticBody2D

@onready var point_light_2d: PointLight2D = $PointLight2D
var tween: Tween

func _ready() -> void:
	tween = create_tween().set_loops()

func alarm() -> void:
	tween.tween_property(point_light_2d, "energy", 0.0, .5)
	tween.tween_property(point_light_2d, "energy", 7.5, .5)

func stop_alarm() -> void: 
	tween.kill()
	tween = create_tween()
	point_light_2d.color = Color.WHITE
	tween.tween_property(point_light_2d, "energy", 0, 0.1)
	tween.tween_property(point_light_2d, "energy", 7.0, 3)
