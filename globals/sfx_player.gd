extends Node

func play(audio: AudioStream, single: bool = false, pitch_scale: float = 1.0) -> void:
	if not audio:
		return
		
	if single:
		stop()
	
	for player in get_children():
		player = player as AudioStreamPlayer
		if not player.playing:
			player.stream = audio
			player.pitch_scale = pitch_scale
			player.play()
			break

func stop():
	for player in get_children():
		player = player as AudioStreamPlayer
		player.stop()
