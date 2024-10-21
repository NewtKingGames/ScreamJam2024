class_name FirstLevel
extends Level

@onready var simple_lights: Node2D = $SimpleLights

# Scripted scenario where player finished the second lock turns off the lights and starts the enemy chase

@onready var left_exit_door_lock_interactable: InteractableNode = $LeftExitDoorLockInteractable

func _ready() -> void:
	super._ready()
	for child in simple_lights.get_children():
		var simple_light = child as SimpleLight
		if simple_light:
			simple_light.alarm()
	left_exit_door_lock_interactable.interactable_complete.connect(_on_interactable_complete)

func _on_interactable_complete() -> void:
	print("stuff is happening")
	# Spawn a darkness enemy
	spawn_darkness_enemy(Vector2(-182.243, 1368))
	# Turn off all of the lights
	for light in $SecondRoomLights.get_children():
		if light is TogglableLight:
			light.turn_off()
	

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
