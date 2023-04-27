extends CanvasLayer

func _on_next_button_pressed():
	hide()
	SoundPlayer.play_sound(SoundPlayer.BUTTON_CLICK)
	UserInterface.start_level()
	get_tree().paused = false


func _on_next_button_mouse_entered():
	SoundPlayer.play_sound(SoundPlayer.BUTTON_HOVER)
