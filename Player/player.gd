extends CharacterBody2D

enum {
	BAT,
	HUMANOID
}

@onready var animated_sprite = $AnimatedSprite2D
@onready var bat_collision_shape = $BatCollisionShape
@onready var humanoid_collision_shape = $HumanoidCollisionShape

var state = HUMANOID

@export var FLYING_SPEED : float = 300.0
@export var WALKING_SPEED : float = 100.0
@export var MAX_GRAVITY : float = 100.0
@export var JUMP_VELOCITY : float = -200.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	match state:
		BAT :
			animated_sprite.play("Bat")
			bat_state(delta)
		HUMANOID :
			animated_sprite.play("Humanoid") 
			humanoid_state(delta)
	
func bat_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_axis("move_left", "move_right")
	input_vector.y = Input.get_axis("move_up", "move_down")
	velocity = input_vector.normalized() * FLYING_SPEED
	move_and_slide()
	
	if velocity.x :
		animated_sprite.flip_h = velocity.x < 0
		
	if Input.is_action_just_pressed("toggle"):
		state = HUMANOID
		bat_collision_shape.disabled = true
		humanoid_collision_shape.disabled = false
		
func humanoid_state(delta):
	var direction_x = Input.get_axis("move_left", "move_right")
	
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	velocity.x = direction_x * WALKING_SPEED
	velocity.y = min(velocity.y, MAX_GRAVITY)
	move_and_slide()
		
	if velocity.x:
		animated_sprite.flip_h = velocity.x < 0
	
	if Input.is_action_just_pressed("toggle"):
		state = BAT
		bat_collision_shape.disabled = false
		humanoid_collision_shape.disabled = true

func _on_hurtbox_area_entered(area):
	if state == BAT:
		queue_free()
