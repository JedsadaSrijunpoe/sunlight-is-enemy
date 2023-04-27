extends CanvasLayer

var texts : Array
@onready var dialog_box = $DialogBox
	
func begin_story(text_array):
	show()
	get_tree().paused = true
	dialog_box.text = text_array.pop_front()
	texts = text_array

func _on_next_button_pressed():
	SoundPlayer.play_sound(SoundPlayer.BUTTON_CLICK)
	if texts.is_empty():
		get_tree().paused = false
		if UserInterface.get_current_level_num() == 5:
			get_tree().change_scene_to_packed(UserInterface.next_scene)
			UserInterface.end_level_screen.hide()
		else:
			UserInterface.start_level()
		hide()
	else:
		dialog_box.text = texts.pop_front()

func _on_next_button_mouse_entered():
	SoundPlayer.play_sound(SoundPlayer.BUTTON_HOVER)
