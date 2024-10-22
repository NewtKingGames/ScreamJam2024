class_name ArrowIcon
extends TextureRect

var GREEN_ARROW_H = load("res://sprites/green_arrow_h.png")
var GREEN_ARROW_V = load("res://sprites/green_arrow_v.png")
var RED_ARROW_H = load("res://sprites/red_arrow_h.png")
var RED_ARROW_V = load("res://sprites/red_arrow_v.png")
@export var arrow_direction: ArrowInteractable.ArrowInputType

func _ready():
	set_icon(false)

func set_icon(inputted: bool) -> void:
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
