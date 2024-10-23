class_name ButtonPromptInteractablePanel
extends Panel


@onready var button: Button = %Button
@onready var label: Label = $Label

@export var button_prompt_resource: ButtonPromptInteractable


func init(button_prompt_resource: ButtonPromptInteractable) -> void:
	self.button_prompt_resource = button_prompt_resource
	_set_text_label_for_index(0)

func _ready() -> void:
	button.pressed.connect(_on_button_press)

func _on_button_press():
	var new_index = button_prompt_resource.handle_press()
	if new_index != -1:
		_set_text_label_for_index(new_index)
	
func _set_text_label_for_index(index: int) -> void:
	label.text = button_prompt_resource.messages[index]
