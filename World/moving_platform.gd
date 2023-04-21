extends Node2D

@export var offset = Vector2(0, 0)
@export var duration = 3.0

@onready var animatable_body = $AnimatableBody2D

func _ready():
	start_tween()

func start_tween():
	var tween = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.set_loops().set_parallel(false)
	tween.tween_property(animatable_body, "position", offset, duration / 2)
	tween.tween_property(animatable_body, "position", Vector2.ZERO, duration / 2)
