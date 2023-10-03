extends Node

@onready var audio := $Audio

func audio_play(stream: AudioStream, bus := &"Master", volume := 0.0, pitch := 1.0) -> AudioStreamPlayer:
	var player = AudioStreamPlayer.new()
	player.stream = stream
	player.bus = bus
	player.volume_db = volume
	player.pitch_scale = pitch
	player.finished.connect(on_audio_finished.bind(player))
	
	audio.add_child(player)
	player.play()
	
	return player

func audio_play_2d(stream: AudioStream, position: Vector2, max_distance := 2000.0, attenuation := 1.0, bus := &"Master", volume := 0.0, pitch := 1.0) -> AudioStreamPlayer2D:
	var player = AudioStreamPlayer2D.new()
	player.stream = stream
	player.bus = bus
	player.volume_db = volume
	player.pitch_scale = pitch
	player.position = position
	player.max_distance = max_distance
	player.attenuation = attenuation
	player.finished.connect(on_audio_finished.bind(player))
	
	audio.add_child(player)
	player.play()
	
	return player

func audio_stop_all():
	for child in audio.get_children():
		child.queue_free()

func audio_stop(stream: AudioStream):
	for child in audio.get_children():
		if child.stream == stream:
			child.queue_free()

func on_audio_finished(audio):
	audio.queue_free()
