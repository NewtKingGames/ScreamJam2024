extends Area2D
@onready var hallway_lights_flash: HallWayLightsFlash = $"../HallwayLightsFlash"


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		hallway_lights_flash.start_light_pattern()
