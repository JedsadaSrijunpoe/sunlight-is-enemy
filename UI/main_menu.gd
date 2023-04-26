extends Control

func _ready():
	SoundPlayer.play_bgm(SoundPlayer.NORMAL_THEME)

func _on_play_pressed():
	SoundPlayer.play_sound(SoundPlayer.BUTTON_CLICK)
	get_tree().change_scene_to_file("res://UI/story_scene.tscn")


func _on_play_mouse_entered():
	SoundPlayer.play_sound(SoundPlayer.BUTTON_HOVER)
