extends Node

const JUMP = preload("res://Sound/Jump.wav")
const FLAP = preload("res://Sound/Flap.wav")
const TRANSFORM = preload("res://Sound/Transform.wav")
const TRANSFORM2 = preload("res://Sound/Transform2.wav")
const ENEMY_KILLED = preload("res://Sound/EnemyKilled.wav")

@onready var audio_players = $AudioPlayers

func play_sound(sound):
	for audio_player in audio_players.get_children():
		if not audio_player.playing:
			audio_player.stream = sound
			audio_player.play()
			break
