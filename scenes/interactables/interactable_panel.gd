class_name InteractablePanel
extends Panel

# The idea of this class is to accept an incoming InteractableResource to the player and after
# the player completes the appropriate actions do the resources effect
# I'm wondering if you should make child scenes per the different type of interactable object

var interactable_resource: Interactable
var active_child_node: Node2D
var is_active: bool = false

func show_panel(interactable: Interactable) -> void:
	# Duplicate the resource to reset progress
	interactable_resource = interactable.duplicate()
	show()
	is_active = true

func hide_panel() -> void:
	hide()
	is_active = false
 
func _process(delta: float) -> void:
	# We should call the child 'active_child_node' scene's process function
	pass

func _input(event: InputEvent) -> void:
	if is_active:
		print(event)
