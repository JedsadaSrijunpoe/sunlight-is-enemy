extends CharacterBody2D

@onready var sprite = $Sprite2D

@export var WALK_SPEED = 50.0
@export var RUN_SPEED = 200.0
const JUMP_VELOCITY = -200.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var past_velocity

func _ready():
	velocity.x = WALK_SPEED
	past_velocity = velocity
	
func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if is_on_wall():
		velocity.x = -past_velocity.x
	
	past_velocity = velocity
	
	move_and_slide()
	if velocity.x:
		sprite.flip_h = velocity.x < 0
