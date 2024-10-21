class_name FirstLevel
extends Level

@onready var simple_lights: Node2D = $SimpleLights

# Scripted scenario where player finished the second lock turns off the lights and starts the enemy chase

@onready var left_exit_door_lock_interactable: InteractableNode = $LeftExitDoorLockInteractable
@onready var lights_turn_back_on_area: Area2D = $LightsTurnBackOnArea
@onready var paper_note_by_light_terminal: PaperNote = $PaperNoteByLightTerminal
@onready var hallway_lights: Node2D = $HallwayLights


var lights_have_turned_off: bool = false

var paper_read: bool = false

func _ready() -> void:
	super._ready()
	for child in simple_lights.get_children():
		var simple_light = child as SimpleLight
		if simple_light:
			simple_light.alarm()
	left_exit_door_lock_interactable.interactable_complete.connect(_on_interactable_complete)
	lights_turn_back_on_area.body_entered.connect(_on_body_entered)
	paper_note_by_light_terminal.paper_closed.connect(_on_paper_read_one_shot)

func _on_paper_read_one_shot() -> void:
	if paper_read:
		return
	paper_read = true
	for child in hallway_lights.get_children():
		if child is TogglableLight:
			child.turn_off()
	

func _on_interactable_complete() -> void:
	lights_have_turned_off = true
	# Spawn a darkness enemy
	spawn_darkness_enemy(Vector2(-182.243, 1368))
	# Turn off all of the lights
	for light in $SecondRoomLights.get_children():
		if light is TogglableLight:
			light.turn_off()

func _on_body_entered(body: Node2D) -> void:
	if lights_have_turned_off:
		for child in $SecondRoomLights.get_children():
			if child is TogglableLight:
				child.turn_on()


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
