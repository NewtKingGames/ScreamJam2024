class_name EnemyState
extends Node

enum State {IDLE, STARTING, CHASING}

signal transition_requested(from: EnemyState, to: State)

@export var state: State
var player: Player
var enemy: DarknessEnemy


func enter() -> void:
	pass

func exit() -> void:
	pass
	
func process(_delta: float) -> void:
	pass

func physics_process(_delta: float) -> void:
	pass
