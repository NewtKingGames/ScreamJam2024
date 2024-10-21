class_name LevelExitDoorLock
extends Node2D

signal lock_unlocked(LevelExitDoorLock)
@onready var point_light_2d: PointLight2D = $PointLight2D


var locked_color: Color = Color.CRIMSON
var unlocked_color: Color = Color.LIME_GREEN

var is_locked: bool = true

func _ready() -> void:
	point_light_2d.color = locked_color

func unlock() -> void:
	is_locked = false
	lock_unlocked.emit(self)
	point_light_2d.color = unlocked_color
