extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_switch_switch_state_changed(activated):
	if activated:
		$CollisionShape2D.disabled = true
		$Sprite2D.hide()
	else:
		$CollisionShape2D.disabled = false
		$Sprite2D.show()
