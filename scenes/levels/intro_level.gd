extends Level

@onready var intro_interactable: InteractableNode = $IntroInteractable

func _ready() -> void:
	_on_player_started_interaction(intro_interactable)
	
