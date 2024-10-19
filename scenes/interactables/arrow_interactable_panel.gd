class_name ArrowInteractablePanel
extends HBoxContainer
# I still think you're thinking incorrectly about resources and nodes, these seem very tightly bound
@export var arrow_resource: ArrowInteractable
var arrow_icon_nodes: Array[ArrowIcon] = []
@export var arrow_icon_scene: PackedScene = preload("res://scenes/interactables/arrow_icon.tscn")
var arrow_icon_index: int = 0



func init(arrow_resource: ArrowInteractable) -> void:
	self.arrow_resource = arrow_resource
	arrow_resource.input_complete.connect(_on_resource_input_completed)
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
		arrow_icon_index = index_from_handle_input
		get_child(arrow_icon_index).set_icon(true)
	#if arrow_resource.handle_input(input):
		#print("setting something to green")
		#get_child(arrow_icon_index).set_icon(true)
		#arrow_icon_index+=1


func _on_resource_input_completed():
	print("the resource completed!")
