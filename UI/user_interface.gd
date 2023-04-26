extends Control

@onready var end_level_screen = $EndLevelScreen
@onready var label_timer = $Timer
@onready var setting = $Setting
@onready var story_scene = $StoryScene

var raw_timer = 0
var timer = 0
var level = 0
var is_counting = false
var next_scene

func _process(delta):
	if is_counting:
		raw_timer += delta
		# Round down to 3 digits
		timer = snapped(raw_timer, 0.001)
		label_timer.get_node("LabelTimer").text = str(timer)
	
	if Input.is_action_just_pressed("pause") and not setting.visible:
		setting.show()
		get_tree().paused = true
		stop_timer()
	elif Input.is_action_just_pressed("pause") and setting.visible:
		setting.hide()
		if not end_level_screen.visible:
			get_tree().paused = false
		start_timer()

func start_timer():
	is_counting = true
	
func stop_timer():
	is_counting = false
	
func reset_timer():
	raw_timer = 0
	timer = 0
		
func start_level():
	# Start timer
	reset_timer()
	start_timer()
	label_timer.show()
	
	end_level_screen.hide()

func end_level(temp: PackedScene):
	next_scene = temp
	stop_timer()
	label_timer.hide()
	
	end_level_screen.get_node("FinishTime").text = str(snapped(timer, 0.001)) + " s"
	end_level_screen.get_node("LevelNumLabel").text = str(level)
	end_level_screen.show()
	
	CheckPoint.level_passed()

func _on_next_level_button_pressed():
	SoundPlayer.play_sound(SoundPlayer.BUTTON_CLICK)
	level += 1
	if level == 5:
		SoundPlayer.play_bgm(SoundPlayer.BOSS_THEME)
	get_tree().paused = false
	get_tree().change_scene_to_packed(next_scene)
	start_level()


func _on_next_level_button_mouse_entered():
	SoundPlayer.play_sound(SoundPlayer.BUTTON_HOVER)


func _on_done_button_pressed():
	start_timer()
