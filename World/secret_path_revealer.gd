extends Node2D

var is_secret_path_found = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $TileMap.modulate.a > 0 and is_secret_path_found:
		$TileMap.modulate.a -= delta

func _on_area_2d_body_entered(body):
	is_secret_path_found = true
