extends Control

@onready var end_level_screen = $CanvasLayer/EndLevelScreen
@onready var label_timer = $CanvasLayer/LabelTimer

var raw_timer = 0
var timer = 0
var level = 0
var is_counting = false
var next_scene

func _ready():
	# Hide the UI
	show_timer(false)
	end_level_screen.hide()

func _process(delta):
	if is_counting:
		raw_timer += delta
		
		# Round down to 3 digits
		timer = snapped(raw_timer, 0.001)
		label_timer.text = str(timer)

func start_timer():
	is_counting = true
	
func stop_timer():
	is_counting = false
	
func reset_timer():
	raw_timer = 0
	timer = 0

func show_timer(is_show: bool):
	if is_show:
		label_timer.show()
	else:
		label_timer.hide()
		
func start_level():
	# Start timer
	reset_timer()
	start_timer()
	show_timer(true)
	
	end_level_screen.hide()

func end_level(temp: PackedScene):
	next_scene = temp
	stop_timer()
	show_timer(false)
	
	end_level_screen.get_node("FinishTime").text = str(snapped(timer, 0.001)) + " s"
	end_level_screen.get_node("LevelNumLabel").text = str(level)
	end_level_screen.show()

func _on_next_level_button_pressed():
	level += 1
	get_tree().paused = false
	get_tree().change_scene_to_packed(next_scene)
	start_level()
