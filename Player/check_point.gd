extends Node

var is_passed_check_point = false
var check_point_position

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_check_point_position():
	if is_passed_check_point:
		return check_point_position
	else:
		return null

func level_passed():
	is_passed_check_point = false
	
func set_check_point_position(new_position):
	check_point_position = new_position
	is_passed_check_point = true
