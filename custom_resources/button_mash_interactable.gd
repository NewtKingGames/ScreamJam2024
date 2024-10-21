class_name ButtonMashInteractable
extends Interactable


@export var starting_progress: float = 20
@export var goal_progress: float = 100
var current_progress = starting_progress
# How much to increment progress per button press
@export var increment_progress: float = 5
# Deplete the bar over time
@export var decrement_rate: float = 0



func handle_press() -> void:
	current_progress+=increment_progress 
	if current_progress >= goal_progress:
		completed_input()
		

func decrement_progress(delta: float) -> void:
	current_progress -= decrement_rate * delta
