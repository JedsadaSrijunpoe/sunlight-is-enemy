extends CanvasLayer

func _on_next_button_pressed():
	hide()
	SoundPlayer.play_sound(SoundPlayer.BUTTON_CLICK)
	get_tree().change_scene_to_file("res://Level/level_0.tscn")
	UserInterface.start_level()


func _on_next_button_mouse_entered():
	SoundPlayer.play_sound(SoundPlayer.BUTTON_HOVER)
