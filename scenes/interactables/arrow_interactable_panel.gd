class_name ArrowInteractablePanel
extends Panel
# CONSIDER EXTENDING SOME BASE CLASS HERE

@onready var description_label: Label = $Label
@onready var arrow_container_parent: HBoxContainer = $ArrowContainerParent

const MEDIUM_BEEP: AudioStream = preload("res://sounds/medium_beep.mp3")
const ERROR_ONE = preload("res://sounds/error_one.mp3")

# This class is just responsible for handing the input to the resource and showing visual effects
@export var arrow_resource: ArrowInteractable
var arrow_icon_nodes: Array[ArrowIcon] = []
@export var arrow_icon_scene: PackedScene = preload("res://scenes/interactables/arrow_icon.tscn")
var arrow_icon_index: int = 0

func init(arrow_resource: ArrowInteractable) -> void:
	# This is purely for development
	for child in arrow_container_parent.get_children():
		if child is ArrowIcon:
			child.queue_free()
	self.arrow_resource = arrow_resource
	var index: int = 0
	for arrow in arrow_resource.arrow_inputs:
		var arrow_icon_node: ArrowIcon = arrow_icon_scene.instantiate()
		arrow_icon_node.arrow_direction = arrow_resource.arrow_inputs[index]
		arrow_icon_nodes.append(arrow_icon_node)
		arrow_container_parent.add_child(arrow_icon_node)
		arrow_icon_node.set_icon(false)
		index+=1
	
	description_label.hide()
	if arrow_resource.effect_description and arrow_resource.effect_description != "":
		description_label.text = arrow_resource.effect_description
		description_label.show()

func handle_input(input: InputEvent):
	var is_any_direction_pressed: bool = input.is_action_pressed("left") or input.is_action_pressed("right") or input.is_action_pressed("up") or input.is_action_pressed("down")
	if not is_any_direction_pressed:
		return
	var index_from_handle_input = arrow_resource.handle_input(input)
	if index_from_handle_input != -1:
		SfxPlayer.play(MEDIUM_BEEP, false, randf_range(0.95, 1.05))
		arrow_icon_index = index_from_handle_input
		arrow_container_parent.get_child(arrow_icon_index).set_icon(true)
	else:
		SfxPlayer.play(ERROR_ONE)
