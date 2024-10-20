class_name FirstLevel
extends Level


@onready var simple_lights: Node2D = $SimpleLights



func _ready() -> void:
	super._ready()
	for child in simple_lights.get_children():
		var simple_light = child as SimpleLight
		if simple_light:
			simple_light.alarm()
		
