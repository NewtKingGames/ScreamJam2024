class_name Player
extends CharacterBody2D


@onready var state_machine: PlayerStateMachine = $StateMachine

var interactable_near: Interactable

func _ready() -> void:
	state_machine.init(self)

func _process(delta: float) -> void:
	state_machine.process(delta)
	look_at(get_global_mouse_position())
	#print(Input.is_action_pressed("down"))
	move_and_slide()

func _physics_process(delta: float) -> void:
	state_machine.physics_process(delta)

func entered_interactable_area(interactable: Interactable) -> void:
	print(interactable)
	interactable_near = interactable

func exited_interactable_area(interactable: Interactable) -> void: 
	interactable_near = null
