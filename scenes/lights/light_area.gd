class_name LightArea
extends Area2D

# Think about how this might work with introducting lights going on and off... I wonder if you just deactivate
# the area if the light will be called automatically?
var is_active: bool = true
var is_player_in_this_light: bool = false

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	

func _on_body_entered(body: Node2D) -> void:
	if body is Player and is_active:
		is_player_in_this_light = true
		Events.player_entered_light_area.emit()

func _on_body_exited(body: Node2D) -> void:
	if body is Player and is_player_in_this_light:
		is_player_in_this_light = false
		Events.player_exited_light_area.emit()
	
