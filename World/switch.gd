extends Area2D

var entered = false
var activated = false
signal switch_state_changed(state)

func _process(delta):
	# Toggle the switch
	if entered and Input.is_action_just_pressed("interact"):
		activated = not activated
		switch_state_changed.emit(activated)
	
	# Flip the switch sprite
	if activated:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false
