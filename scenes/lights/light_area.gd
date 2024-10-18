class_name LightArea
extends Area2D


func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		Events.player_entered_light_area.emit()

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		Events.player_exited_light_area.emit()
	
