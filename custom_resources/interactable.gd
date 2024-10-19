class_name Interactable
extends Resource

enum InteractableType {ARROW, BUTTON_MASH}
@export var type: InteractableType

signal input_complete

# Should do something
func completed_input() -> void:
	input_complete.emit()
