class_name HallWayLightsFlash
extends Node2D

@onready var lights: Node2D = $Lights

enum LightPattern{STATIC, IN_ORDER, BACK_FORTH}

@export var pattern: LightPattern = LightPattern.STATIC
@export var light_on_duration: float = 4.5
@export var delay_until_next_light: float = 4
@export var auto_start_pattern: bool = true
@export var backwards: bool = false
var are_all_lights_on: bool = false
var are_lights_flashing: bool = true
var light_child_index: int = 0
var next_light_child_index: int = 0
var total_light_children: int = 0
var light_child_index_increment: int = 1


func _ready() -> void:
	if backwards:
		light_child_index = lights.get_child_count() -1
		light_child_index_increment = -1
	next_light_child_index = get_next_light_index(light_child_index)
	total_light_children = lights.get_child_count()
	toggle_all_lights(are_all_lights_on)
	if auto_start_pattern:
		start_light_pattern()

func move_to_next_lights() -> void:
	print("getting next lights")
	light_child_index = next_light_child_index
	next_light_child_index = get_next_light_index(next_light_child_index)
	print("new current")
	print(light_child_index)
	print("new next")
	print(next_light_child_index)

func toggle_all_lights(on: bool) -> void:
	for light in lights.get_children():
		if light is SimpleLight:
			if on:
				light.turn_on()
			else:
				light.turn_off()

func start_light_pattern() -> void:
	turn_on_light_with_timer_to_off(light_child_index)

func turn_on_light_with_timer_to_off(index: int) -> void:
	turn_on_light(index)
	get_tree().create_timer(light_on_duration).timeout.connect(
		func():
			turn_off_light(index)
	)
	get_tree().create_timer(delay_until_next_light).timeout.connect(
		func():
			turn_on_light_with_timer_to_off(get_next_light_index(index))
	)

func turn_off_light(index: int) -> void:
	lights.get_children()[index].turn_off()
	
func turn_on_light(index: int) -> void:
	lights.get_children()[index].turn_on()

func get_next_light_index(current_index: int) -> int:
	if pattern == LightPattern.IN_ORDER:
		# light_child_index_increment is always 1 here
		return (current_index + light_child_index_increment) % total_light_children
	else:
		if current_index == total_light_children - 1:
			# If we're on the last index
			light_child_index_increment = -1
		elif current_index == 0:
			light_child_index_increment = 1
		return current_index + light_child_index_increment
