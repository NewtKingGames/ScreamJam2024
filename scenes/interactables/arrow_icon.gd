class_name ArrowIcon
extends TextureRect

const GREEN_ARROW_H = preload("res://sprites/green_arrow_h.png")
const GREEN_ARROW_V = preload("res://sprites/green_arrow_v.png")
const RED_ARROW_H = preload("res://sprites/red_arrow_h.png")
const RED_ARROW_V = preload("res://sprites/red_arrow_v.png")
@export var arrow_direction: ArrowInteractable.ArrowInputType
var inputted: bool = false

func _ready():
	set_icon(false)

func set_icon(inputted: bool) -> void:
	print(arrow_direction)
	if inputted and arrow_direction == ArrowInteractable.ArrowInputType.UP:
		texture = GREEN_ARROW_V
	if inputted and arrow_direction == ArrowInteractable.ArrowInputType.DOWN:
		texture = GREEN_ARROW_V
		flip_v = true
	if inputted and arrow_direction == ArrowInteractable.ArrowInputType.RIGHT:
		texture = GREEN_ARROW_H
	if inputted and arrow_direction == ArrowInteractable.ArrowInputType.LEFT:
		texture = GREEN_ARROW_H
		flip_h = true
	
	if not inputted and arrow_direction == ArrowInteractable.ArrowInputType.UP:
		texture = RED_ARROW_V
	if not inputted and arrow_direction == ArrowInteractable.ArrowInputType.DOWN:
		texture = RED_ARROW_V
		flip_v = true
	if not inputted and arrow_direction == ArrowInteractable.ArrowInputType.RIGHT:
		texture = RED_ARROW_H
	if not inputted and arrow_direction == ArrowInteractable.ArrowInputType.LEFT:
		texture = RED_ARROW_H
		flip_h = true
