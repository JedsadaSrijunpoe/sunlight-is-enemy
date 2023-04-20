extends Sprite2D

var opened_window = preload("res://Hazard/window.png")
var closed_window = preload("res://Hazard/closed_window.png")

func _on_switch_switch_state_changed(activated):
	if activated:
		$"Hitbox/CollisionPolygon2D".disabled = true
		$"Hitbox/Sprite2D".hide()
		texture = closed_window
	else:
		$"Hitbox/CollisionPolygon2D".disabled = false
		$"Hitbox/Sprite2D".show()
		texture = opened_window
