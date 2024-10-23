extends Node2D

@onready var level_exit_interactable: InteractableNode = $"../LevelExitInteractable"
@onready var point_light_2d: PointLight2D = $Lights/PointLight2D
@onready var point_light_2d_2: PointLight2D = $Lights/PointLight2D2
@onready var point_light_2d_3: PointLight2D = $Lights/PointLight2D3
@onready var area_2d: Area2D = $Area2D

var level: Level
var player: Player


func _ready() -> void:
	level_exit_interactable.interactable_complete.connect(_on_complete)
	area_2d.body_entered.connect(_player_entered)
	player = get_tree().get_first_node_in_group("player")
	level = get_tree().get_first_node_in_group("level")

func _on_complete() -> void:
	# Play some kind of noise?
	var tween: Tween = create_tween().set_parallel()
	tween.tween_property(point_light_2d, "energy", 35, 6.0)
	tween.tween_property(point_light_2d_2, "energy", 35, 6.0)
	tween.tween_property(point_light_2d_3, "energy", 35, 6.0)
	
func _player_entered(node: Node2D) -> void:
	if node is Player:
		var tween: Tween = create_tween()
		tween.tween_property(player, "speed", 0, 1.5)
		tween.finished.connect(
			func():
				print("ending level")
				level.player_exited_level()
		)
