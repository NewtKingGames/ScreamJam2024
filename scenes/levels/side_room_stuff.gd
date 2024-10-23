class_name SideRoomStuff
extends Node

@onready var door: Door = $SmallDoors/Door
@onready var door_2: Door = $SmallDoors/Door2
@onready var side_room_interactable: InteractableNode = $"../SideRoomInteractable"
@onready var interactable_to_escape: InteractableNode = $"../InteractableToEscape"

@onready var side_room_lights: Node2D = $SideRoomLights
const MONSTER_GROWL_WITH_IMPACT = preload("res://sounds/monster_growl_with_impact.mp3")


func _ready() -> void:
	side_room_interactable.interactable_complete.connect(_on_side_interactable_done)
	interactable_to_escape.interactable_complete.connect(_on_escape_interactable_done)
	
func _on_side_interactable_done() -> void:
	# Close the door
	door_2.close()
	# Open the other
	door.open()
	await get_tree().create_timer(0.1).timeout
	SfxPlayer.play(MONSTER_GROWL_WITH_IMPACT)
	await get_tree().create_timer(0.45).timeout
	# Iteratively turn off the lights
	for child in side_room_lights.get_children():
		await get_tree().create_timer(1).timeout
		child.turn_off()

func _on_escape_interactable_done() -> void:
	var child_index = side_room_lights.get_child_count() -1 
	while child_index >= 0:
		var child = side_room_lights.get_children()[child_index]
		child.turn_on()
		await get_tree().create_timer(0.25).timeout
		child_index -=1
		
