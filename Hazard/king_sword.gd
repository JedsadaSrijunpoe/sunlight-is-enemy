extends Node2D

@onready var raycast = $RayCast2D
@onready var PickCollision = $Hitbox/PickUp/CollisionShape2D
@onready var StuckArea = $Hitbox/StuckArea/CollisionShape2D
@onready var Hitbox = $Hitbox
@onready var end_point : Vector2

@export var duration : float = 3
@export var rotation_speed : float = 0.5
@export var angle = 60

var tween : Tween
var activated : bool = false
var state = DAYLIGHT
var last_shot_state = DAYLIGHT
var rotation_direction : bool = true
var starting_rotation

signal sword_picked_up

enum{
	DAYLIGHT , NIGHT , STUCK
}

func _ready():
	starting_rotation = rotation_degrees
	end_point = raycast.target_position

func _physics_process(delta):
	match state:
		DAYLIGHT:
			PickCollision.disabled = true
			StuckArea.disabled = true
			if(not activated):
				if(rotation_direction):
					rotation += PI * delta * rotation_speed
					if(rotation_degrees >= starting_rotation + angle):
						rotation_direction = false
				else:
					rotation -= PI * delta * rotation_speed
					if(rotation_degrees <= starting_rotation - angle):
						rotation_direction = true
			initiate_tween()
		NIGHT:
			PickCollision.disabled = false
			StuckArea.disabled = false
			if(not activated):
				rotation_degrees = starting_rotation
			initiate_tween()
		STUCK:
			pass
			
func initiate_tween():
	if(raycast.is_colliding() and not activated):
		activated = true
		tween = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
		tween.connect("finished",finish)
		tween.tween_property(Hitbox,"position",end_point,duration)
		last_shot_state = state
		
func finish():
	activated = false
	Hitbox.global_position = global_position
	#tween.disconnect("finished",finish)
	tween.kill()
	rotation_degrees = starting_rotation
	
func _on_stuck_area_body_entered(body):
	if last_shot_state == NIGHT and state == NIGHT:
		activated = false
		state = STUCK
		if(tween != null):
			tween.kill()

func _on_pick_up_body_entered(body):
	emit_signal("sword_picked_up")
	queue_free()
