extends Area2D

@export var next_scene : PackedScene

func _on_body_entered(body):
	if body.name == "Player":
		SoundPlayer.play_sound(SoundPlayer.NEXT_LEVEL)
		get_tree().change_scene_to_packed(next_scene)
		
