class_name PaperNote
extends Node2D


@export_multiline var paper_message: String = ""

@onready var area_2d: Area2D = $Area2D
@onready var panel: Panel = $CanvasLayer/Panel
@onready var label: Label = %Label


var is_player_near: bool = false
var is_paper_active: bool = false

func _ready() -> void:
	panel.hide()
	area_2d.body_entered.connect(_on_body_entered)
	area_2d.body_exited.connect(_on_body_exited)
	label.text = paper_message

func _process(delta: float) -> void:
	if is_player_near and Input.is_action_just_pressed("interact"):
		read_paper()
	if is_paper_active and Input.is_action_just_pressed("exit"):
		put_away_paper()

func read_paper() -> void:
	is_paper_active = true
	# Play noise
	panel.show()
	
func put_away_paper() -> void:
	is_paper_active = false
	# Play noise
	panel.hide()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		is_player_near = true

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		is_player_near = false
		if is_paper_active:
			put_away_paper()

