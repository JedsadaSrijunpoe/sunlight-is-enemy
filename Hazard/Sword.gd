extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_circular_time_day_change():
	pass # Replace with function body.
	for sword in get_children():
		if(sword.state == sword.DAYLIGHT):
			sword.state = sword.NIGHT 
		elif sword.state == sword.NIGHT:
			sword.rotation_direction = true
			sword.state = sword.DAYLIGHT
		else:
			sword.get_node("Hitbox").global_position = sword.global_position
			sword.rotation_direction = true
			sword.state = sword.DAYLIGHT
	
