class_name ArrowInteractablePanel
extends HBoxContainer

@export var arrow_inputs: Array[ArrowInteractable.ArrowInputType] = []
var arrow_icon_nodes: Array[ArrowIcon] = []
@export var arrow_icon_scene: PackedScene = preload("res://scenes/interactables/arrow_icon.tscn")


func _ready():
	var index: int = 0
	for arrow in arrow_inputs:
		var arrow_icon_node: ArrowIcon = arrow_icon_scene.instantiate()
		arrow_icon_node.arrow_direction = arrow_inputs[index]
		arrow_icon_nodes.append(arrow_icon_node)
		#arrow_icon_nodes[index] = arrow_icon_node
		add_child(arrow_icon_node)
		arrow_icon_node.set_icon(false)
		index+=1
	for child in get_children():
		print(child.rotation)

