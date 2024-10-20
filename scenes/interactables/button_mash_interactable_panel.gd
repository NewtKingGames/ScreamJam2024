class_name ButtonMashInteractablePanel
extends Panel


@onready var button: Button = %Button
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var description_label: Label = $Label

@export var button_mash_resource: ButtonMashInteractable

func init(button_mash_resource: ButtonMashInteractable) -> void:
	self.button_mash_resource = button_mash_resource
	description_label.hide()
	if button_mash_resource.effect_description and button_mash_resource.effect_description != "":
		description_label.text = button_mash_resource.effect_description
		description_label.show()

func _ready() -> void:
	button.pressed.connect(_on_button_press)


func _process(delta: float) -> void:
	progress_bar.value = button_mash_resource.current_progress
	button_mash_resource.decrement_progress(delta)


func _on_button_press():
	button_mash_resource.handle_press()
