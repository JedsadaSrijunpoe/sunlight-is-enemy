extends CharacterBody2D

# In case we have enough time to do enemy AI.
enum {
	PATROL,
	CHASE
}

# The directions the knight can go toward.
enum {
	START,
	DEST
}

var state = PATROL
# The current direction the knight is going toward.
var patrol_dest = DEST

@onready var sprite = $Sprite2D
@onready var collision_shape = $CollisionShape2D
@onready var hitbox = $Hitbox
@onready var hurtbox = $Hurtbox
@onready var start = $Node/Start
@onready var destination = $Node/Destination

## The knight's walking speed
@export var WALK_SPEED = 50.0
## The knight's running speed
@export var RUN_SPEED = 200.0

# Unused
#const JUMP_VELOCITY = -200.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# Setting the direction record and velocity record.
var past_velocity = Vector2.ZERO
var past_direction = 1
var direction = 1

func _ready():
	# Setting the the direction the knight face toward initially.
	if global_position.direction_to(destination.global_position).x < 0:
		sprite.flip_h = true
		hitbox.get_node("CollisionPolygon2D").scale.x *= -1
		hitbox.get_node("CollisionPolygon2D").position.x *= -1

func _physics_process(delta):
	# Change the direction that the knight goes toward.
	match patrol_dest:
		DEST : go_toward_dest(delta)
		START : go_toward_start(delta)
		
	# Record the velocity of the knight and move accordingly.
	past_velocity = velocity
	move_and_slide()
	
	# Flip the knight's sprite and hitbox when changing direction
	if velocity.x and past_direction != direction:
		sprite.flip_h = not sprite.flip_h
		hitbox.get_node("CollisionPolygon2D").scale.x *= -1
		hitbox.get_node("CollisionPolygon2D").position.x *= -1
		# Record the changed direction
		past_direction = direction
		
# Move toward Destination position and change direction when near the position.
func go_toward_dest(delta):
	velocity = Vector2.ZERO
	if global_position.distance_to(destination.global_position) >= WALK_SPEED * delta:
		var direction_x = global_position.direction_to(destination.global_position).x
		velocity.x = direction_x * WALK_SPEED
	else:
		past_direction *= -1
		patrol_dest = START
	
# Move toward Start position and change direction when near the position.
func go_toward_start(delta):
	velocity = Vector2.ZERO
	if global_position.distance_to(start.global_position) >= WALK_SPEED * delta:
		var direction_x = global_position.direction_to(start.global_position).x
		velocity.x = direction_x * WALK_SPEED
	else:
		past_direction *= -1
		patrol_dest = DEST
		
# Kill the knight when they step in the trap.
func _on_hurtbox_area_entered(area):
	if not area.IS_LIGHT:
		SoundPlayer.play_sound(SoundPlayer.ENEMY_KILLED)
		queue_free()

# Kill the knight when they got stomped.
func _on_stomp_hurtbox_area_entered(_area):
	SoundPlayer.play_sound(SoundPlayer.ENEMY_KILLED)
	queue_free()
