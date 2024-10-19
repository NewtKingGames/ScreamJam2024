class_name InteractablePanel
extends Panel

# The idea of this class is to accept an incoming InteractableResource to the player and after
# the player completes the appropriate actions do the resources effect
# I'm wondering if you should make child scenes per the different type of interactable object


var arrow_interactable_panel_scene: PackedScene = load("res://scenes/interactables/arrow_interactable_panel.tscn")


var current_interactable_resource: Interactable
var current_interactable_node: InteractableNode 
var active_child_node: Node
var is_active: bool = false

func show_panel(interactable: InteractableNode) -> void:
	current_interactable_node = interactable
	is_active = true
	if current_interactable_node.interactable_resource.type == Interactable.InteractableType.ARROW:
		# Duplicate the resource to reset progress
		current_interactable_resource = current_interactable_node.interactable_resource.duplicate(true) as ArrowInteractable
		var child_scene: ArrowInteractablePanel = arrow_interactable_panel_scene.instantiate()
		add_child(child_scene)
		child_scene.init(current_interactable_resource)
		#child_scene.arrow_resource = interactable_resource
		active_child_node = child_scene
	current_interactable_resource.input_complete.connect(_on_resource_input_completed)
	show()

func _on_resource_input_completed():
	print("the resource completed!")
	# now we have access to the node object and can do somethign with it
	current_interactable_node.do_effect()
	hide_panel()
	

func hide_panel() -> void:
	hide()
	is_active = false
 
func _process(delta: float) -> void:
	# We should call the child 'active_child_node' scene's process function
	pass

func _input(event: InputEvent) -> void:
	if is_active:
		active_child_node.handle_input(event)
