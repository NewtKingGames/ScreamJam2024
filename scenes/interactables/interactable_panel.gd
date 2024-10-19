class_name InteractablePanel
extends Panel

# The idea of this class is to accept an incoming InteractableResource to the player and after
# the player completes the appropriate actions do the resources effect
# I'm wondering if you should make child scenes per the different type of interactable object


var arrow_interactable_panel_scene: PackedScene = load("res://scenes/interactables/arrow_interactable_panel.tscn")


var interactable_resource: Interactable
var active_child_node: Node
var is_active: bool = false

func show_panel(interactable: Interactable) -> void:
	# Duplicate the resource to reset progress
	#interactable_resource = interactable.duplicate(true)
	show()
	is_active = true
	if interactable.type == Interactable.InteractableType.ARROW:
		# Duplicate the resource to reset progress
		interactable_resource = interactable.duplicate(true) as ArrowInteractable
		var child_scene: ArrowInteractablePanel = arrow_interactable_panel_scene.instantiate()
		add_child(child_scene)
		child_scene.init(interactable_resource)
		#child_scene.arrow_resource = interactable_resource
		active_child_node = child_scene

func hide_panel() -> void:
	hide()
	is_active = false
 
func _process(delta: float) -> void:
	# We should call the child 'active_child_node' scene's process function
	pass

func _input(event: InputEvent) -> void:
	if is_active:
		active_child_node.handle_input(event)
