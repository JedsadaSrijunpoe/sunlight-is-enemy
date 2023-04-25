extends Node2D
# Called when the node enters the scene tree for the first time.
@onready var raycast = $RayCast2D
@onready var end_point : Vector2
@export var duration : float
var tween : Tween
var activated : bool = false

func _ready():
	end_point = raycast.target_position

func _physics_process(delta):
	if(raycast.is_colliding() and not activated ):
		activated = true
		tween = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
		tween.connect("finished",finish)
		tween.tween_property($Hitbox,"position",end_point,duration)
		
func finish():
	activated = false
	$Hitbox.global_position = global_position
	#tween.disconnect("finished",finish)
	tween.kill()

	
		
