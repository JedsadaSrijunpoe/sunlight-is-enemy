extends Control

@onready var end_level_screen = $EndLevelScreen
@onready var label_timer = $Timer
@onready var setting = $Setting
@onready var story_scene = $StoryScene

const BOSS_LEVEL_NUM = 5

var raw_timer = 0
var timer = 0
var is_counting = false
var next_scene

func _process(delta):
	if is_counting:
		raw_timer += delta
		# Round down to 3 digits
		timer = snapped(raw_timer, 0.001)
		label_timer.get_node("LabelTimer").text = str(timer)
	
	if Input.is_action_just_pressed("pause"):
		toggle_setting_window()

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
	end_level_screen.get_node("LevelNumLabel").text = str(get_current_level_num())
	end_level_screen.show()
	
	CheckPoint.level_passed()

func _on_next_level_button_pressed():
	SoundPlayer.play_sound(SoundPlayer.BUTTON_CLICK)
	if get_current_level_num() == BOSS_LEVEL_NUM:
		get_tree().paused = true
		story_scene.begin_story(["The king is killed and the night has returned. The people of the Lightania shall now know your pain. \n\nThe End"])
	else:
		if get_current_level_num()+1 == BOSS_LEVEL_NUM:
			SoundPlayer.play_bgm(SoundPlayer.BOSS_THEME)
		get_tree().paused = false
		get_tree().change_scene_to_packed(next_scene)
		start_level()

func _on_next_level_button_mouse_entered():
	SoundPlayer.play_sound(SoundPlayer.BUTTON_HOVER)

func toggle_setting_window():
	# If setting window is open, close it, and vice versa.
	if setting.visible:
		setting.hide()
		start_timer()
		# Dont unpaused if end level screen still open.
		if not (end_level_screen.visible or story_scene.visible):
			get_tree().paused = false
	else:
		SoundPlayer.stop_sound_in_loop(SoundPlayer.LOOP_FLAP)
		setting.show()
		stop_timer()
		get_tree().paused = true
		
func get_current_level_num():
	var current_scene_name = get_tree().current_scene.name
	var current_scene_name_split = current_scene_name.split("_")
	if current_scene_name_split[0] == "level":
		return int(current_scene_name_split[1])
	else:
		return null
	
