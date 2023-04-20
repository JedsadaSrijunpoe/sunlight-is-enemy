extends CharacterBody2D

@onready var sprite = $Sprite2D
@onready var collision_shape = $CollisionShape2D
@onready var hitbox = $Hitbox
@onready var hurtbox = $Hurtbox


@export var WALK_SPEED = 50.0
@export var RUN_SPEED = 200.0
const JUMP_VELOCITY = -200.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var past_velocity
var past_direction
var direction

func _ready():
	velocity.x = WALK_SPEED
	past_velocity = velocity
	past_direction = 1
	direction = 1
	
func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if is_on_wall():
		print("wall")
		velocity.x = -past_velocity.x
		print(velocity)
		direction = -past_direction
	
	past_velocity = velocity
	
	move_and_slide()
	
	if velocity.x and past_direction != direction:
		sprite.flip_h = not sprite.flip_h
		past_direction = direction
		hitbox.get_node("CollisionPolygon2D").scale.x *= -1
		hitbox.get_node("CollisionPolygon2D").position.x *= -1
		
func _on_hurtbox_area_entered(area):
	if not area.IS_LIGHT:
		queue_free()
