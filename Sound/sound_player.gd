extends Node

const JUMP = preload("res://Sound/Jump.wav")
const FLAP = preload("res://Sound/Flap.wav")
const TRANSFORM = preload("res://Sound/Transform.wav")
const TRANSFORM2 = preload("res://Sound/Transform2.wav")
const ENEMY_KILLED = preload("res://Sound/EnemyKilled.wav")
const PLAYER_DEATH = preload("res://Sound/PlayerDeath.wav")
const LEVER = preload("res://Sound/Lever.wav")
const NEXT_LEVEL = preload("res://Sound/NextLevel.wav")
const BUTTON_HOVER = preload("res://Sound/ButtonHover.wav")
const BUTTON_CLICK = preload("res://Sound/ButtonClick.wav")
const KING_SWORD_ATTACK = preload("res://Sound/KingswordAttack.wav")
const KING_SWORD_PICKUP = preload("res://Sound/KingswordPickup.wav")

const LOOP_FLAP = preload("res://Sound/LoopingFlap.wav")

const NORMAL_THEME = preload("res://Sound/Soring.wav")
const BOSS_THEME = preload("res://Sound/Tunica.mp3")

@onready var audio_players = $AudioPlayers
@onready var looping_audio_players = $LoopingAudioPlayers
@onready var bgm = $BGM/AudioStreamPlayer

# Play a sound one time.
func play_sound(sound):
	for audio_player in audio_players.get_children():
		if not audio_player.playing:
			audio_player.stream = sound
			audio_player.play()
			break

# Play a sound in loop.
func play_sound_in_loop(sound):
	for audio_player in looping_audio_players.get_children():
		if audio_player.stream == sound:
			audio_player.stream.set_loop_mode(1)
			audio_player.play()
			break
			
# Stop a sound playing in loop.
func stop_sound_in_loop(sound):
	for audio_player in looping_audio_players.get_children():
		if audio_player.stream == sound:
			audio_player.stream.set_loop_mode(0)
			break
			
# Kill all sound in the loop immediately.
func kill_all_loop():
	for audio_player in looping_audio_players.get_children():
		audio_player.stop()
		audio_player.seek(0)
	
# Play background music
func play_bgm(sound):
	bgm.stream = sound
	bgm.play()

# Stop background music
func stop_bgm():
	bgm.stop()
