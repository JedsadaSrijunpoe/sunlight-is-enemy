extends StaticBody2D

@export var start_disabled: bool
var is_activated

func _ready():
	is_activated = not start_disabled

func  _process(_delta):
	if is_activated:
		$Hitbox/CollisionPolygon2D.disabled = false
		$Hitbox/Flame.show()
	else:
		$Hitbox/CollisionPolygon2D.disabled = true
		$Hitbox/Flame.hide()
		
func _on_switch_switch_state_changed(activated):
	is_activated = activated

func _on_switch_toggle_state_changed(_activated):
	is_activated = not is_activated
