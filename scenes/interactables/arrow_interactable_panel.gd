class_name ArrowInteractablePanel
extends HBoxContainer
# CONSIDER EXTENDING SOME BASE CLASS HERE

# TODO  refactor all of this to be in a global class
#@onready var correct_input: AudioStreamPlayer = $CorrectInput
#@onready var incorrect_input: AudioStreamPlayer = $IncorrectInput


# This class is just responsible for handing the input to the resource and showing visual effects
@export var arrow_resource: ArrowInteractable
var arrow_icon_nodes: Array[ArrowIcon] = []
@export var arrow_icon_scene: PackedScene = preload("res://scenes/interactables/arrow_icon.tscn")
var arrow_icon_index: int = 0

func init(arrow_resource: ArrowInteractable) -> void:
	# This is purely for development
	for child in get_children():
		if child is ArrowIcon:
			child.queue_free()
	self.arrow_resource = arrow_resource
	var index: int = 0
	for arrow in arrow_resource.arrow_inputs:
		var arrow_icon_node: ArrowIcon = arrow_icon_scene.instantiate()
		arrow_icon_node.arrow_direction = arrow_resource.arrow_inputs[index]
		arrow_icon_nodes.append(arrow_icon_node)
		add_child(arrow_icon_node)
		arrow_icon_node.set_icon(false)
		index+=1

func handle_input(input: InputEvent):
	var index_from_handle_input = arrow_resource.handle_input(input)
	if index_from_handle_input != -1:
		#correct_input.pitch_scale = randf_range(.8, 1.10)
		#correct_input.play()
		arrow_icon_index = index_from_handle_input
		get_child(arrow_icon_index).set_icon(true)
