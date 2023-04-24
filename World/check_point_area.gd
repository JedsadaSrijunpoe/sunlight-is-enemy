extends Area2D

@onready var check_point_position = $CheckPointPosition

func _on_body_entered(body):
	CheckPoint.set_check_point_position(check_point_position.global_position)
