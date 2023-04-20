extends Area2D

# entered will be true when player enter switch area.
var entered = false

var activated = false
signal switch_state_changed(activated)

func _process(_delta):
	# Toggle the switch
	if entered and Input.is_action_just_pressed("interact"):
		activated = not activated
		switch_state_changed.emit(activated)
	
	# Flip the switch sprite
	if activated:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false
