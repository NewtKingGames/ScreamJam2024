class_name Interacting
extends PlayerState


func _ready():
	Events.interaction_completed.connect(_on_interaction_completed)

func process(delta: float) -> void:
	if not player.interactable_near:
		transition_requested.emit(self. State.IDLE)
		return
	if Input.is_action_just_pressed("exit"):
		player.interactable_near.player_exit_interaction()
		transition_requested.emit(self, State.IDLE)
	

# subscribe to the signal when a interactable is completed in order to exit this state
func _on_interaction_completed(interactable: InteractableNode) -> void:
	# TODO - this might be problematic...
	transition_requested.emit(self, State.IDLE)
