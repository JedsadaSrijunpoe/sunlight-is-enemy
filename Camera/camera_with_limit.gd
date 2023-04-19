extends Camera2D

@onready var bottom_right = $Node/BottomRight
@onready var top_left = $Node/TopLeft

func _ready():
	limit_left = top_left.position.x
	limit_right = bottom_right.position.x
	limit_top = top_left.position.y
	limit_bottom = bottom_right.position.y
