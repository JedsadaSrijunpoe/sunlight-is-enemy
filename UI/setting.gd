extends CanvasLayer

@onready var master_volume_slider = $MasterVolumeSlider
@onready var music_volume_slider = $MusicVolumeSlider
@onready var effect_volume_slider = $EffectVolumeSlider

func _on_done_button_pressed():
	SoundPlayer.play_sound(SoundPlayer.BUTTON_CLICK)
	UserInterface.toggle_setting_window()


func _on_done_button_mouse_entered():
	SoundPlayer.play_sound(SoundPlayer.BUTTON_HOVER)


func _on_master_volume_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)


func _on_music_volume_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)


func _on_effect_volume_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effect"), value)
