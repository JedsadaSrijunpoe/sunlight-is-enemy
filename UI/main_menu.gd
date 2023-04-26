extends Control

func _ready():
	SoundPlayer.play_bgm(SoundPlayer.NORMAL_THEME)

func _on_play_pressed():
	SoundPlayer.play_sound(SoundPlayer.BUTTON_CLICK)
	UserInterface.get_node("StoryScene").show()


func _on_play_mouse_entered():
	SoundPlayer.play_sound(SoundPlayer.BUTTON_HOVER)


func _on_main_menu_button_pressed():
	SoundPlayer.play_sound(SoundPlayer.BUTTON_CLICK)
	UserInterface.get_node("Setting").show()
