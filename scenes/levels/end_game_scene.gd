extends Panel

@onready var end_game_music: AudioStreamPlayer = $AudioStreamPlayer
@onready var footstep: AudioStreamPlayer = $Footstep

@onready var title_label: Label = $TitleLabel

@onready var author_label: Label = $AuthorLabel
@onready var thanks_for_playing: Label = $ThanksForPlaying


func _ready() -> void:
	# Hide all labels
	_hide(title_label)
	_hide(author_label)
	_hide(thanks_for_playing)
	var tween: Tween = create_tween()
	tween.tween_property(title_label, "modulate", Color(1,1,1,1), 2.0)
	tween.tween_property(author_label, "modulate", Color(1,1,1,1), 2.0)
	tween.tween_property(thanks_for_playing, "modulate", Color(1,1,1,1), 2.0)
	get_tree().create_timer(15.0).timeout.connect(_on_timer_done)

func _hide(node: Node) -> void:
	node.modulate = Color(1,1,1,0)


func _on_timer_done() -> void:
	var tween_music: Tween = create_tween().set_parallel(true)
	tween_music.tween_property(end_game_music, "volume_db", -20, 16)
	var tween_foot: Tween = create_tween()
	tween_foot.tween_interval(5)
	tween_foot.tween_callback(footstep.play)
	tween_foot.tween_property(footstep, "volume_db", 10, 9)
	tween_foot.finished.connect(
		func():
			get_tree().quit()
	)
	
