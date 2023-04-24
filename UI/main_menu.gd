extends Control

func _on_play_pressed():
	SoundPlayer.play_sound(SoundPlayer.BUTTON_CLICK)
	get_tree().change_scene_to_file("res://Level/level_0.tscn")
	UserInterface.start_level()


func _on_play_mouse_entered():
	SoundPlayer.play_sound(SoundPlayer.BUTTON_HOVER)
