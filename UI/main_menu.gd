extends Control

@export var level_0_scene : PackedScene = preload("res://Level/level_0.tscn")

func _ready():
	SoundPlayer.play_bgm(SoundPlayer.NORMAL_THEME)

func _on_play_pressed():
	SoundPlayer.play_sound(SoundPlayer.BUTTON_CLICK)
	UserInterface.get_node("StoryScene").begin_story(["In the kingdom of Lightania, the vampires are hunted by the people of the kingdom out of fear.",
	"The king plans to use his power remove the night from the cycle of time to completely eradicate the vampire.",
	"If you don't take revenge for you breathens now, you might neve have the chance again. \n\nIn other word, Kill the king."])
	get_tree().change_scene_to_packed(level_0_scene)


func _on_play_mouse_entered():
	SoundPlayer.play_sound(SoundPlayer.BUTTON_HOVER)


func _on_main_menu_button_pressed():
	SoundPlayer.play_sound(SoundPlayer.BUTTON_CLICK)
	UserInterface.get_node("Setting").show()
