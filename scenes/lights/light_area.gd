class_name LightArea
extends Area2D

# Think about how this might work with introducting lights going on and off... I wonder if you just deactivate
# the area if the light will be called automatically?
var is_active: bool = true :
	set(value):
		if value and is_player_in_this_light and not is_active:
			Events.player_entered_light_area.emit()
		elif not value and is_player_in_this_light and is_active:
			Events.player_exited_light_area.emit()
		is_active = value
var is_player_in_this_light: bool = false :
	set(value):
		if value and is_active and not is_player_in_this_light:
			Events.player_entered_light_area.emit()
		elif not value and is_active and is_player_in_this_light:
			Events.player_exited_light_area.emit()
		is_player_in_this_light = value

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	

func _on_body_entered(body: Node2D) -> void:
	is_player_in_this_light = true

func _on_body_exited(body: Node2D) -> void:
	is_player_in_this_light = false
