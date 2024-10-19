class_name ButtonMashInteractable
extends Interactable


@export var starting_progress: float
@export var goal_progress: float
var current_progress = starting_progress
# How much to increment progress per button press
@export var increment_progress: float
# Deplete the bar over time
@export var decrement_rate: float



func handle_press() -> void:
	current_progress+=increment_progress 
	if current_progress >= goal_progress:
		completed_input()
		

func decrement_progress(delta: float) -> void:
	current_progress -= decrement_rate * delta
