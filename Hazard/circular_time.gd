extends Node2D

@onready var timer = $Timer
@onready var animation = $AnimationPlayer

@export var Period : float = 9
@export var delay : float = 1

signal DayChange() 
var IsDay : bool = true
# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start(Period)


func _on_animation_player_animation_finished(anim_name):
	timer.start(Period)
	DayChange.emit()


func _on_timer_timeout():
	if(IsDay):
		animation.play("DayChange")
	else:
		animation.play("NightChange")
	IsDay = not IsDay
