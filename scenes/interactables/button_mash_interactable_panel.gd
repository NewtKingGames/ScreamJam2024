class_name ButtonMashInteractablePanel
extends Panel

var is_active: bool = true

@onready var button: Button = %Button
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var description_label: Label = $Label

@export var button_mash_resource: ButtonMashInteractable

func init(button_mash_resource: ButtonMashInteractable) -> void:
	self.button_mash_resource = button_mash_resource
	self.button_mash_resource.input_complete.connect(
		func():
			is_active = false
	)
	description_label.hide()
	if button_mash_resource.effect_description and button_mash_resource.effect_description != "":
		description_label.text = button_mash_resource.effect_description
		description_label.show()

func _ready() -> void:
	button.pressed.connect(_on_button_press)


func _process(delta: float) -> void:
	progress_bar.value = button_mash_resource.current_progress
	if is_active:
		button_mash_resource.decrement_progress(delta)


func _on_button_press():
	if is_active:
		button_mash_resource.handle_press()
