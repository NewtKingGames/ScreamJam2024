class_name Interactable
extends Resource

enum InteractableType {ARROW, BUTTON_MASH}
@export var type: InteractableType

# Should do something
func completed_input() -> void:
	pass
