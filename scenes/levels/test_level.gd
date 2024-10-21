class_name Level
extends Node2D

@onready var transition_rect: ColorRect = $CanvasLayer/TransitionRect

@export var next_level: PackedScene

@onready var interactable_panel: InteractablePanel = %InteractablePanel
const ZAPSPLAT_LAB_MACHINE_WHIRR_107536 = preload("res://sounds/zapsplat_lab_machine_whirr_107536.mp3")
@onready var ambient_noise_player: AudioStreamPlayer = $AmbientNoisePlayer


func _ready() -> void:
	var level_trans_tween: Tween = create_tween()
	level_trans_tween.tween_property(transition_rect, "color", Color(0, 0, 0, 0.0), 1.0)
	interactable_panel.hide()
	Events.player_started_interaction.connect(_on_player_started_interaction)
	Events.player_exited_interaction.connect(_on_player_exited_interaction)
	Events.player_exited_level.connect(player_exited_level)

func _on_player_started_interaction(interactable_node: InteractableNode) -> void:
	interactable_panel.show_panel(interactable_node)

func _on_player_exited_interaction(interactable_node: InteractableNode) -> void:
	interactable_panel.hide_panel()

func player_exited_level():
	if next_level:
		var level_trans_tween: Tween = create_tween()
		level_trans_tween.tween_property(transition_rect, "color", Color(0, 0, 0, 1.0), 1.5)
		await level_trans_tween.finished
		#await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_packed(next_level)
	else:
		print("game ended")
