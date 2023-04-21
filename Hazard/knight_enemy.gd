extends CharacterBody2D

enum {
	PATROL,
	CHASE
}

enum {
	START,
	DEST
}

var state = PATROL
var patrol_dest = DEST

@onready var sprite = $Sprite2D
@onready var collision_shape = $CollisionShape2D
@onready var hitbox = $Hitbox
@onready var hurtbox = $Hurtbox
@onready var start = $Node/Start
@onready var destination = $Node/Destination


@export var WALK_SPEED = 50.0
@export var RUN_SPEED = 200.0
const JUMP_VELOCITY = -200.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var past_velocity = Vector2.ZERO
var past_direction = 1
var direction = 1

func _ready():
	if global_position.direction_to(destination.global_position).x < 0:
		sprite.flip_h = true
		hitbox.get_node("CollisionPolygon2D").scale.x *= -1
		hitbox.get_node("CollisionPolygon2D").position.x *= -1

func _physics_process(delta):
	
	match patrol_dest:
		DEST : go_toward_dest(delta)
		START : go_toward_start(delta)
		
	past_velocity = velocity
	move_and_slide()
	
	if velocity.x and past_direction != direction:
		sprite.flip_h = not sprite.flip_h
		past_direction = direction
		hitbox.get_node("CollisionPolygon2D").scale.x *= -1
		hitbox.get_node("CollisionPolygon2D").position.x *= -1
		
func go_toward_dest(delta):
	velocity = Vector2.ZERO
	if global_position.distance_to(destination.global_position) >= WALK_SPEED * delta:
		var direction_x = global_position.direction_to(destination.global_position).x
		velocity.x = direction_x * WALK_SPEED
	else:
		past_direction *= -1
		patrol_dest = START
	
func go_toward_start(delta):
	velocity = Vector2.ZERO
	if global_position.distance_to(start.global_position) >= WALK_SPEED * delta:
		var direction_x = global_position.direction_to(start.global_position).x
		velocity.x = direction_x * WALK_SPEED
	else:
		past_direction *= -1
		patrol_dest = DEST
		
func _on_hurtbox_area_entered(area):
	if not area.IS_LIGHT:
		queue_free()

func _on_stomp_hurtbox_area_entered(area):
	queue_free()
