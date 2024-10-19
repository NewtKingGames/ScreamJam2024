class_name InteractableNode
extends StaticBody2D

const COMPUTER_DEACTIVATED_SPRITE = preload("res://sprites/computer3.png")

@export var interactable_resource: Interactable
@export var effect: Effect
@export var target: Node2D


@onready var player_area: Area2D = $PlayerArea
@onready var interact_label: Label = %InteractLabel
# TODO - maybe it makes more sense to have this interact panel happen at the top level scene so we can
# block out the whole screen with it. If we do this then we probably want a global signal and have the interactable
# emit some kind of resource/scene which the main interaction panel can read and show to the player

var is_interactable: bool = true: 
	set(value):
		if value == false:
			$Sprite2D.texture = COMPUTER_DEACTIVATED_SPRITE
			interact_label.hide()
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
	if is_interactable:
		interact_label.hide()
		var player = body as Player
		if player:
			player.exited_interactable_area(self)

func player_interacted() -> void:
	Events.player_started_interaction.emit(self)

func player_exit_interaction() -> void:
	Events.player_exited_interaction.emit(self)

func do_effect() -> void:
	if not target:
		return
	effect.perform_action(target)
	if not effect.is_repeatable:
		is_interactable = false
	# TODO - add shome check in the effect resource like "is repeatable" and if it's not switch to the deactivated skin
