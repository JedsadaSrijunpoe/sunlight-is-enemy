extends StaticBody2D

@export var start_disabled: bool
@export var secret_door: bool
var is_activated

# Called when the node enters the scene tree for the first time.
func _ready():
	is_activated = not start_disabled

func  _process(_delta):
	if is_activated:
		$CollisionShape2D.disabled = false
		$Sprite2D.show()
	else:
		$CollisionShape2D.disabled = true
		$Sprite2D.hide()
	
	if secret_door:
		$Sprite2D.hide()
		
func _on_switch_switch_state_changed(_activated):
	is_activated = not is_activated
