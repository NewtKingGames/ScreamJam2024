class_name SimpleLight
extends StaticBody2D

@onready var point_light_2d: PointLight2D = $PointLight2D

func alarm() -> void:
	var tween: Tween = create_tween().set_loops()
	
	tween.tween_property(point_light_2d, "energy", 0.0, .5)
	tween.tween_property(point_light_2d, "energy", 7.5, .5)
