extends CanvasLayer

@onready var master_volume_slider = $MasterVolumeSlider
@onready var music_volume_slider = $MusicVolumeSlider
@onready var effect_volume_slider = $EffectVolumeSlider

# Called when the node enters the scene tree for the first time.
func _ready():
	master_volume_slider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	music_volume_slider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
	effect_volume_slider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Effect"))

func _on_done_button_pressed():
	SoundPlayer.play_sound(SoundPlayer.BUTTON_CLICK)
	get_tree().paused = false
	hide()


func _on_done_button_mouse_entered():
	SoundPlayer.play_sound(SoundPlayer.BUTTON_HOVER)


func _on_master_volume_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)


func _on_music_volume_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)


func _on_effect_volume_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effect"), value)
