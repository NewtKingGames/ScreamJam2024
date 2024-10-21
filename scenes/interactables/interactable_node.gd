class_name InteractableNode
extends StaticBody2D

# TODO - you could add one or two sounds to make this less tedius
@onready var startup_noise: AudioStreamPlayer2D = $StartupNoise
@onready var powerdown_noise: AudioStreamPlayer2D = $PowerdownNoise


const COMPUTER_DEACTIVATED_SPRITE = preload("res://sprites/computer3.png")

@export var interactable_resource: Interactable
@export var effect: Effect
@export var targets: Array[Node2D]
@export var effect_delay: float = 0.0

@onready var interactable_light: PointLight2D = $interactable_light
@onready var player_area: Area2D = $PlayerArea
@onready var interact_label: Label = %InteractLabel

var is_interactable: bool = true: 
	set(value):
		if value == false:
			$Sprite2D.texture = COMPUTER_DEACTIVATED_SPRITE
			interact_label.hide()
			interactable_light.enabled = false
		is_interactable = value

func _ready() -> void:
	interact_label.hide()
	player_area.body_entered.connect(_on_player_entered_area)
	player_area.body_exited.connect(_on_player_exited_area)

func _on_player_entered_area(body: Node2D) -> void:
	if is_interactable:
		interact_label.show()
		var player = body as Player
		if player:
			player.entered_interactable_area(self)
	
func _on_player_exited_area(body: Node2D) -> void:
	#if is_interactable:
	powerdown_noise.play()
	interact_label.hide()
	var player = body as Player
	if player:
		player.exited_interactable_area(self)

func player_interacted() -> void:
	startup_noise.pitch_scale = randf_range(0.90, 1.0)
	startup_noise.play()
	Events.player_started_interaction.emit(self)

func player_exit_interaction() -> void:
	Events.player_exited_interaction.emit(self)

func do_effect() -> void:
	await get_tree().create_timer(effect_delay).timeout
	if not targets:
		return
	effect.perform_actions(targets)
	if not effect.is_repeatable:
		is_interactable = false
