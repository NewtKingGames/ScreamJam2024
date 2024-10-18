extends Node2D

@onready var interactable_panel: Panel = %InteractablePanel

func _ready() -> void:
	interactable_panel.hide()
	Events.player_started_interaction.connect(_on_player_started_interaction)
	Events.player_exited_interaction.connect(_on_player_exited_interaction)

func _on_player_started_interaction() -> void:
	interactable_panel.show()

func _on_player_exited_interaction() -> void:
	interactable_panel.hide()
