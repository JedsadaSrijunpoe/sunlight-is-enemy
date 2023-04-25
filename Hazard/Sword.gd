extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_circular_time_day_change():
	pass # Replace with function body.
	for sword in get_children():
		if(sword.state == sword.DayLight):
			sword.state = sword.Night 
		else:
			sword.state = sword.DayLight
