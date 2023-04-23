extends Control

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Level/level_0.tscn")
	UserInterface.start_level()
