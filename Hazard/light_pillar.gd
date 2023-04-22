extends Sprite2D



func _on_switch_switch_state_changed(activated):
	if activated:
		$Hitbox/CollisionPolygon2D.disabled = true
		hide()
	else:
		$Hitbox/CollisionPolygon2D.disabled = false
		show()
