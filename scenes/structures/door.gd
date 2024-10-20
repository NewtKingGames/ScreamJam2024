class_name Door
extends Node2D

@export var is_open: bool = false

@onready var door_left_side: Node2D = $DoorLeftSide
@onready var door_right_side: Node2D = $DoorRightSide
@onready var door_open_player: AudioStreamPlayer2D = $DoorOpenPlayer
@onready var door_close_player: AudioStreamPlayer2D = $DoorClosePlayer


# X scale for closed and open state
var close_scale: float = 1.0
var open_scale: float = 0.1

func _ready():
	if is_open:
		door_left_side.scale.x = open_scale
		door_right_side.scale.x = open_scale
	else:
		door_left_side.scale.x = close_scale
		door_right_side.scale.x = close_scale

func open():
	if is_open:
		return
	toggle()

func close():
	if not is_open:
		return
	toggle()

func toggle():
	var tween = create_tween()
	tween.set_parallel(true)
	if is_open:
		tween.tween_property(door_left_side, "scale", Vector2(close_scale, 1), 1.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CIRC)
		tween.tween_property(door_right_side, "scale", Vector2(close_scale, 1), 1.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CIRC)
		door_close_player.play()
		#Play door closing effects
	else:
		tween.tween_property(door_left_side, "scale", Vector2(open_scale, 1), 1.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CIRC)
		tween.tween_property(door_right_side, "scale", Vector2(open_scale, 1), 1.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CIRC)
		door_open_player.play()
		#play door opening effects
	is_open = not is_open
