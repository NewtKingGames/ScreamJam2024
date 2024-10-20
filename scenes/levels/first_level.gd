class_name FirstLevel
extends Level

@onready var simple_lights: Node2D = $SimpleLights

func _ready() -> void:
	super._ready()
	for child in simple_lights.get_children():
		var simple_light = child as SimpleLight
		if simple_light:
			simple_light.alarm()

func stop_alarm () -> void:
	var tween: Tween = create_tween()
	tween.tween_property($AlarmSound, "pitch_scale", 0.25, 2.5)
	
	tween.finished.connect(
		func():
			$AlarmSound.stop()
			for child in simple_lights.get_children():
				var simple_light = child as SimpleLight
				if simple_light:
					simple_light.stop_alarm()
			$AmbientNoisePlayer.play()
	)
