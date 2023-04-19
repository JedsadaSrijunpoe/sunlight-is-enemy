extends Area2D

@onready var timer = $Timer
@onready var collision_shape = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_entered(area):
	collision_shape.set_deferred("disabled", true)
	timer.start(0.1)
	
func _on_timer_timeout():
	collision_shape.disabled = false
