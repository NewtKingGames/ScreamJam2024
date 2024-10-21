class_name EnemyStateMachine
extends Node


@export var initial_state: EnemyState

var current_state: EnemyState
var states:= {}

func init(enemy: CharacterBody2D) -> void:
	for child in get_children():
		if child is EnemyState:
			states[child.state] = child
			child.transition_requested.connect(_on_transition_requested)
			child.enemy = enemy
			child.player = get_tree().get_first_node_in_group("player")
	if initial_state:
		initial_state.enter()
		current_state = initial_state


func process(delta: float) -> void:
	if current_state:
		current_state.process(delta)

func physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_process(delta)

func _on_transition_requested(from: EnemyState, to: EnemyState.State) -> void:
	if from != current_state:
		return
	var new_state: EnemyState = states[to]
	if not new_state:
		return
	if current_state:
		current_state.exit()
	new_state.enter()
	current_state = new_state
