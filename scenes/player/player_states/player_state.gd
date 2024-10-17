class_name PlayerState
extends Node

enum State {IDLE, WALKING, INTERACTING}

signal transition_requested(from: PlayerState, to: State)

@export var state: State
var player: Player


func enter() -> void:
	pass

func exit() -> void:
	pass
	
func process(_delta: float) -> void:
	pass

func physics_process(_delta: float) -> void:
	pass
