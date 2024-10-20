# TODO I should rename this to something like "parent"
class_name InteractablePanel
extends Panel

# The idea of this class is to accept an incoming InteractableResource to the player and after
# the player completes the appropriate actions do the resources effect
# I'm wondering if you should make child scenes per the different type of interactable object
const DEFAULT_INPUT_COMPLETE_NOISE: AudioStream = preload("res://sounds/double_beep.wav")

var arrow_interactable_panel_scene: PackedScene = load("res://scenes/interactables/arrow_interactable_panel.tscn")
var button_mash_interactable_panel_scene: PackedScene = load("res://scenes/interactables/button_mash_interactable_panel.tscn")
var button_prompt_interactable_panel_scene: PackedScene = load("res://scenes/interactables/button_prompt_interactable_panel.tscn")

var current_interactable_resource: Interactable
var current_interactable_node: InteractableNode 
var active_child_node: Node
var is_active: bool = false

func show_panel(interactable: InteractableNode) -> void:
	current_interactable_node = interactable
	is_active = true
	var child_scene
	if current_interactable_node.interactable_resource.type == Interactable.InteractableType.ARROW:
		# Duplicate the resource to reset progress
		current_interactable_resource = current_interactable_node.interactable_resource.duplicate(true) as ArrowInteractable
		child_scene = arrow_interactable_panel_scene.instantiate() as ArrowInteractablePanel
	elif current_interactable_node.interactable_resource.type == Interactable.InteractableType.BUTTON_MASH:
		current_interactable_resource = current_interactable_node.interactable_resource.duplicate(true) as ButtonMashInteractable
		child_scene = button_mash_interactable_panel_scene.instantiate() as ButtonMashInteractablePanel
	elif current_interactable_node.interactable_resource.type == Interactable.InteractableType.BUTTON_PROMPT:
		current_interactable_resource = current_interactable_node.interactable_resource.duplicate(true) as ButtonPromptInteractable
		child_scene = button_prompt_interactable_panel_scene.instantiate() as ButtonPromptInteractablePanel

	add_child(child_scene)
	child_scene.init(current_interactable_resource)
	active_child_node = child_scene
	current_interactable_resource.input_complete.connect(_on_resource_input_completed)
	show()

func _on_resource_input_completed():
	# Perform visual effects
	# now we have access to the node object and can do somethign with it
	is_active = false
	await get_tree().create_timer(0.05).timeout
	success_effects()
	await get_tree().create_timer(1).timeout
	current_interactable_node.do_effect()
	Events.interaction_completed.emit(current_interactable_node)
	hide_panel()
	
func success_effects() -> void:
	if "input_complete_sound" in current_interactable_resource:
		SfxPlayer.play(current_interactable_resource.input_complete_sound)
	else:
		SfxPlayer.play(DEFAULT_INPUT_COMPLETE_NOISE)

func hide_panel() -> void:
	hide()
	for child in get_children():
		child.queue_free()
	is_active = false
 
func _process(delta: float) -> void:
	# We should call the child 'active_child_node' scene's process function
	pass

func _input(event: InputEvent) -> void:
	# This is super hacky "has_method" approach but it's a game jam...
	if is_active and active_child_node.has_method("handle_input"):
		active_child_node.handle_input(event)
