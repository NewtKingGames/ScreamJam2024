class_name PaperNote
extends Node2D


@export_multiline var paper_message: String = ""

@onready var area_2d: Area2D = $Area2D
@onready var panel: Panel = $CanvasLayer/Panel
@onready var label: Label = %Label
@onready var interact_label: Label = $InteractLabel
@onready var open_sound: AudioStreamPlayer2D = $OpenSound
@onready var close_sound: AudioStreamPlayer2D = $CloseSound


signal paper_opened
signal paper_closed

var is_player_near: bool = false
var is_paper_active: bool = false

func _ready() -> void:
	panel.hide()
	interact_label.hide()
	area_2d.body_entered.connect(_on_body_entered)
	area_2d.body_exited.connect(_on_body_exited)
	label.text = paper_message

func _process(delta: float) -> void:
	interact_label.visible = is_player_near
	if is_player_near and Input.is_action_just_pressed("interact") and not is_paper_active:
		read_paper()
	elif is_paper_active and (Input.is_action_just_pressed("exit") or Input.is_action_just_pressed("interact")):
		put_away_paper()

func read_paper() -> void:
	if is_paper_active:
		return
	is_paper_active = true
	panel.show()
	paper_opened.emit()
	open_sound.play()
	
func put_away_paper() -> void:
	if not is_paper_active:
		return
	is_paper_active = false
	panel.hide()
	paper_closed.emit()
	close_sound.play()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		is_player_near = true

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		is_player_near = false
		if is_paper_active:
			put_away_paper()

