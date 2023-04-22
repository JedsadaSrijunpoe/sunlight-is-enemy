extends CharacterBody2D

enum {
	BAT,
	HUMANOID
}

@onready var animated_sprite = $AnimatedSprite2D
@onready var bat_collision_shape = $BatCollisionShape
@onready var humanoid_collision_shape = $HumanoidCollisionShape
@onready var bat_hurtbox = $BatHurtbox
@onready var human_hurtbox = $HumanHurtbox
@onready var hitbox = $Hitbox
@onready var switch_hitbox = $Switchbox

var state = HUMANOID

## The player's movespeed in bat form.
@export var FLYING_SPEED : float = 300.0
## The player's movespeed in humanoid form.
@export var WALKING_SPEED : float = 100.0
## The maximum gravity force that can effect the player in humanoid form.
@export var MAX_GRAVITY : float = 100.0
## The vertical velocity gained from jumping.
@export var JUMP_VELOCITY : float = -275.0
## The vertical velocity gained from flapping. (jumping in bat form)
@export var FLAP_VELOCITY : float = -80.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Handle movement
func _physics_process(delta):
	match state:
		BAT :
			animated_sprite.play("Bat")
			bat_state(delta)
		HUMANOID :
			animated_sprite.play("Humanoid")
			humanoid_state(delta)
	
# Handle movement in bat form.
func bat_state(delta):
	var input_vector = Vector2.ZERO
	var direction_x = Input.get_axis("move_left", "move_right")
#	input_vector.x = Input.get_axis("move_left", "move_right")
#	input_vector.y = Input.get_axis("move_up", "move_down")
	#velocity = input_vector.normalized() * FLYING_SPEED
	velocity.x = direction_x* WALKING_SPEED
	
	# Flip the sprite horizontally if the direction point to left side.
	if not is_on_floor():
		velocity.y += gravity * 0.125*delta
		
	if Input.is_action_just_pressed("jump"):
		velocity.y  = FLAP_VELOCITY
		
	if velocity.x :
		animated_sprite.flip_h = velocity.x < 0
		
	move_and_slide()
	# Toggle to humanoid state
	if Input.is_action_just_pressed("toggle"):
		state = HUMANOID
		bat_collision_shape.disabled = true
		bat_hurtbox.get_node("CollisionShape2D").disabled = true
		humanoid_collision_shape.disabled = false
		human_hurtbox.get_node("CollisionShape2D").disabled = false
		hitbox.get_node("CollisionPolygon2D").disabled = false
		switch_hitbox.get_node("CollisionShape2D").disabled = false
		velocity.y = 0
		
# Handle movement in human form
func humanoid_state(delta):
	# Get horizontal direction
	var direction_x = Input.get_axis("move_left", "move_right")
	
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Get velocity vector
	velocity.x = direction_x * WALKING_SPEED
	velocity.y = min(velocity.y, MAX_GRAVITY)
	move_and_slide()
		
	# Flip the sprite horizontally if the direction point to left side
	if velocity.x:
		animated_sprite.flip_h = velocity.x < 0
	
	# Toggle to bat state
	if Input.is_action_just_pressed("toggle"):
		state = BAT
		bat_collision_shape.disabled = false
		bat_hurtbox.get_node("CollisionShape2D").disabled = false
		humanoid_collision_shape.disabled = true
		human_hurtbox.get_node("CollisionShape2D").disabled = true
		hitbox.get_node("CollisionPolygon2D").disabled = true
		switch_hitbox.get_node("CollisionShape2D").disabled = true
		velocity.y = 0

# How the player react to hurtbox collision in bat form
func _on_bathurtbox_area_entered(_area):
	call_deferred("respawn")

# How the player react to hurtbox collision in humanoid form
func _on_humanhurtbox_area_entered(area):
	if not area.IS_LIGHT:
		call_deferred("respawn")

# Tell the switch that player has enterer switch area
func _on_switchbox_area_entered(switch):
	switch.entered = true

# Tell the switch that player has exited switch area
func _on_switchbox_area_exited(switch):
	switch.entered = false

# Reload the current scene.
func respawn():
	get_tree().reload_current_scene()
