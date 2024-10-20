class_name Interactable
extends Resource

enum InteractableType {ARROW, BUTTON_MASH, BUTTON_PROMPT}
# This seems a bit weird... I think this should just be set by the child classes?
@export var type: InteractableType
@export var input_complete_sound: AudioStream
@export var input_complete_delay: float = 0.5

signal input_complete

# Should do something
func completed_input() -> void:
	input_complete.emit()
	print("we've emitted the signal")
