class_name ArrowIcon
extends TextureRect

const GREEN_ARROW = preload("res://sprites/green_arrow.png")
const RED_ARROW = preload("res://sprites/red_arrow.png")
@export var arrow_direction: ArrowInteractable.ArrowInputType
var inputted: bool = false

func _ready():
	set_icon(false)

func set_icon(inputted: bool) -> void:
	if inputted:
		texture = GREEN_ARROW
	else:
		texture = RED_ARROW
	if arrow_direction == ArrowInteractable.ArrowInputType.UP:
		rotation_degrees = 270
	if arrow_direction == ArrowInteractable.ArrowInputType.DOWN:
		rotation_degrees = 90
	if arrow_direction == ArrowInteractable.ArrowInputType.LEFT:
		rotation_degrees = 180
