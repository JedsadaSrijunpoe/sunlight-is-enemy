extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_texture_button_pressed():
	SoundPlayer.play_sound(SoundPlayer.BUTTON_CLICK)
	get_tree().change_scene_to_file("res://Level/level_0.tscn")
	UserInterface.start_level()


func _on_texture_button_mouse_entered():
	SoundPlayer.play_sound(SoundPlayer.BUTTON_HOVER)
