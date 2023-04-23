extends Area2D

@export var next_scene : PackedScene

func _on_body_entered(body):
	if body.name == "Player":
		SoundPlayer.kill_all_loop()
		SoundPlayer.play_sound(SoundPlayer.NEXT_LEVEL)
		UserInterface.end_level(next_scene)
		get_tree().paused = true
		
