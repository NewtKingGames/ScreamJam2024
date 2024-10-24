class_name Effect
extends Resource

# TODO - think about just extending this class to have hardcoded function name and object types
@export var method_name: String = "" # TODO see if theres a better way to call the function vame
@export var is_repeatable: bool = true

func perform_action(target: Node2D):
	# TODO add some null checks?
	if not target or not target.has_method(method_name):
		print("SOMETHING WENT WRONG IN EFFECT")
		return
	target.call(method_name)

func perform_actions(targets: Array[Node2D]):
	for target in targets:
		perform_action(target)
