extends Area2D

@export var next_scene : PackedScene

func _on_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_packed(next_scene)
		