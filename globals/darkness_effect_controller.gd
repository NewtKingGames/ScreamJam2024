extends Node

var is_active: bool = true
var tween: Tween
var camera: Camera2D
var player: Player
var camera_starting_zoom: Vector2 # Starts at (0.6, 0.6)
var camera_darkness_zoom: Vector2 = Vector2(1, 1)
@onready var canvas_modulate: CanvasModulate = $CanvasModulate

# Effects we want to do 
# zoom in the camera
# Possibly play some sounds
# possibly modulate the whole scene?
# Make the game even darker?


func _ready() -> void:
	_get_camera_and_player()
	camera_starting_zoom = camera.zoom
	tween = create_tween()
	Events.player_entered_darkness.connect(_on_player_entered_darkness)
	Events.player_exited_darkness.connect(_on_player_exited_darkness)

func _get_camera_and_player() -> void:
	camera = get_tree().get_first_node_in_group("camera") as Camera2D
	player = get_tree().get_first_node_in_group("player") as Player


func _on_player_entered_darkness() -> void:
	print("entering darkness")
	tween.kill()
	tween = create_tween()
	tween.tween_interval(2.0)
	tween.tween_property(camera, "zoom", camera_darkness_zoom, 15)
	# What should the effects be?


func _on_player_exited_darkness() -> void:
	print("exiting darkness")
	tween.kill()
	tween = create_tween()
	tween.tween_property(camera, "zoom", camera_starting_zoom, 2.0)
	pass
