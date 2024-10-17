class_name Player
extends CharacterBody2D


@onready var state_machine: PlayerStateMachine = $StateMachine

func _ready() -> void:
	state_machine.init(self)

func _process(delta: float) -> void:
	state_machine.process(delta)
	look_at(get_global_mouse_position())
	#print(Input.is_action_pressed("down"))
	move_and_slide()

func _physics_process(delta: float) -> void:
	state_machine.physics_process(delta)
