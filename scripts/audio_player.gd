extends Node

var player_hurt_sfx = preload("res://assets/audio/hurt.wav")
var player_jump_sfx = preload("res://assets/audio/jump.wav")
var spring_sfx = preload("res://assets/audio/boing.wav")
var cheer_sfx = preload("res://assets/audio/cheering.wav")
var fanfare_sfx = preload("res://assets/audio/fanfare.wav")

func play_sound_effect(name: String):
	var stream = null
	if name == "player_hurt":
		stream = player_hurt_sfx
	elif name == "player_jump":
		stream = player_jump_sfx
	elif name == "spring_boing":
		stream = spring_sfx
	elif name == "cheer":
		stream = cheer_sfx
	elif name == "fanfare":
		stream = fanfare_sfx
	else:
		printerr("Invalid sound effect name")
		return
	
	var audio_player = AudioStreamPlayer.new()
	audio_player.stream = stream
	audio_player.name = name + "_sfx"
	audio_player.bus = "sfx"
	add_child(audio_player)
	
	audio_player.play()
	await audio_player.finished
	audio_player.queue_free()
