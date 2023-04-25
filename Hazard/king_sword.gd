extends Node2D
# Called when the node enters the scene tree for the first time.
@onready var raycast = $RayCast2D
@onready var PickCollision = $Hitbox/PickUp/CollisionShape2D
@onready var StuckArea = $Hitbox/StuckArea/CollisionShape2D
@onready var Hitbox = $Hitbox
@onready var end_point : Vector2
@export var duration : float
@export var rotation_speed : float = 0.5
var tween : Tween
var activated : bool = false
var state = DayLight
var rotation_direction : bool = true
#var IsStuck : bool = false
enum{
	DayLight , Night , Stuck
}

func _ready():
	end_point = raycast.target_position

func _physics_process(delta):
	match state:
		DayLight:
			#IsStuck = false
			StuckArea.disabled = true
			if(not activated):
				if(rotation_direction):
					rotation += PI*delta*rotation_speed
					if(rotation_degrees >= 60):
						rotation_direction = false
				else:
					rotation -= PI*delta*rotation_speed
					if(rotation_degrees <= -60):
						rotation_direction = true
			initiate_tween()
		Night:
			StuckArea.disabled = false
			if(not activated):
				rotation = 0  
			initiate_tween()
			
	
		
		
func initiate_tween():
	if(raycast.is_colliding() and not activated):
		activated = true
		tween = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
		tween.connect("finished",finish)
		tween.tween_property($Hitbox,"position",end_point,duration)
		#raycast.look_at()
		
func finish():
	activated = false
	$Hitbox.global_position = global_position
	#tween.disconnect("finished",finish)
	tween.kill()
	rotation  = 0 
	
	


	
		


func _on_stuck_area_area_entered(area):
	activated = false
	#IsStuck = true
	state = Stuck
	if(tween != null):
		tween.kill()
