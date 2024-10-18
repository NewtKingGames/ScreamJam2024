class_name Player
extends CharacterBody2D


@onready var state_machine: PlayerStateMachine = $StateMachine

var interactable_near: Interactable
var player_light_count: int = 0 : 
	set(value):
		if value == 0:
			print("player in complete darkness")
			Events.player_entered_darkness.emit()
		elif value > 0 and player_light_count == 0:
			print("player has exited darkness")
			Events.player_exited_darkness.emit()
		player_light_count = value

func _ready() -> void:
	state_machine.init(self)
	Events.player_entered_light_area.connect(_on_player_entered_light)
	Events.player_exited_light_area.connect(_on_player_exited_light)

func _process(delta: float) -> void:
	state_machine.process(delta)
	look_at(get_global_mouse_position())
	move_and_slide()

func _physics_process(delta: float) -> void:
	state_machine.physics_process(delta)

func entered_interactable_area(interactable: Interactable) -> void:
	interactable_near = interactable

func exited_interactable_area(interactable: Interactable) -> void: 
	interactable_near = null


func _on_player_entered_light() -> void:
	player_light_count += 1

func _on_player_exited_light() -> void:
	player_light_count -= 1
