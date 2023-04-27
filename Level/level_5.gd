extends Node2D

var main_menu = load("res://UI/main_menu.tscn")

@onready var swordgroup = $Sword
@onready var animation_player = $AnimationPlayer
@onready var vampire_sword = $VampireSword
@onready var vampire_sword_2 = $VampireSword2
@onready var circular_time = $CircularTime
@onready var label = $Label
@onready var hint_label = $HintLabel

var sword_amount

# Called when the node enters the scene tree for the first time.
func _ready():
	hint_label.show()
	label.hide()
	var temp_sword_amount = 0
	for sword in swordgroup.get_children():
		temp_sword_amount += 1
		sword.connect("sword_picked_up", count_sword)
	sword_amount = temp_sword_amount

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("interact") and sword_amount == 0:
		UserInterface.stop_timer()
		UserInterface.label_timer.hide()
		final_cutscene()
	
func count_sword():
	hint_label.hide()
	sword_amount -= 1
	if sword_amount == 0:
		circular_time.animation.disconnect("animation_finished", circular_time._on_animation_player_animation_finished)
		circular_time.get_node("Timer").stop()
		if circular_time.IsDay and circular_time.animation.is_playing():
			await circular_time.animation.animation_finished
			circular_time.animation.play("DayChange")
		label.show()
	
func final_cutscene():
	label.hide()
	animation_player.play("Final_cutscene")
	
func cutscene_sword_hit():
	SoundPlayer.play_sound(SoundPlayer.ENEMY_KILLED)
	
func king_dies():
	cutscene_sword_hit()
	SoundPlayer.play_sound(SoundPlayer.PLAYER_DEATH)
	
func final_cutscene_done():
	SoundPlayer.stop_bgm()
	UserInterface.end_level(main_menu)
