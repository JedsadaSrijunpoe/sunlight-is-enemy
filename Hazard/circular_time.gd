extends Node2D

@export var Period : float = 9
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(angle_rotation)
	#if(angle_rotation > 2*PI):
		#angle_rotation = 0
	transform = transform.rotated(2*PI*delta/Period)
	#angle_rotation += delta*2*PI
	
