extends Node2D
@onready var togglable_light: TogglableLight = $TogglableLight
@onready var area_2d: Area2D = $Area2D
var one_shot: bool = true

func _ready() -> void:
	area_2d.body_entered.connect(_on_player_entered)

func _on_player_entered(body: Node2D) -> void:
	if body is Player:
		togglable_light.turn_off()
