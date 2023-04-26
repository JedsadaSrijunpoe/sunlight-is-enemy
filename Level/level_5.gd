extends Node2D

@onready var swordgroup = $Sword
@onready var animation_player = $AnimationPlayer
@onready var vampire_sword = $VampireSword
@onready var vampire_sword_2 = $VampireSword2
@onready var circular_time = $CircularTime
@onready var label = $Label

var sword_amount

# Called when the node enters the scene tree for the first time.
func _ready():
	label.hide()
	var temp_sword_amount = 0
	for sword in swordgroup.get_children():
		temp_sword_amount += 1
		sword.connect("sword_picked_up", count_sword)
	sword_amount = temp_sword_amount

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("interact") and sword_amount == 0:
		final_cutscene()
	
func count_sword():
	sword_amount -= 1
	if sword_amount == 0:
		circular_time.get_node("AnimationPlayer").disconnect("animation_finished", circular_time._on_animation_player_animation_finished)
		circular_time.get_node("Timer").stop()
		if circular_time.IsDay:
			circular_time.get_node("AnimationPlayer").play("DayChange")
		label.show()
	
func final_cutscene():
	label.hide()
	animation_player.play("Final_cutscene")
	
func final_cutscene_done():
	SoundPlayer.stop_bgm()
