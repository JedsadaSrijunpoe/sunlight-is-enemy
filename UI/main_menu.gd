extends Control

@export var level_0_scene : PackedScene = preload("res://Level/level_0.tscn")

func _ready():
	SoundPlayer.play_bgm(SoundPlayer.NORMAL_THEME)

func _on_play_pressed():
	SoundPlayer.play_sound(SoundPlayer.BUTTON_CLICK)
	UserInterface.get_node("StoryScene").show()
	get_tree().change_scene_to_packed(level_0_scene)
	get_tree().paused = true


func _on_play_mouse_entered():
	SoundPlayer.play_sound(SoundPlayer.BUTTON_HOVER)


func _on_main_menu_button_pressed():
	SoundPlayer.play_sound(SoundPlayer.BUTTON_CLICK)
	UserInterface.get_node("Setting").show()
