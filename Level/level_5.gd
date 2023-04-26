extends Node2D

@onready var swordgroup = $Sword
@onready var animation_player = $AnimationPlayer
@onready var vampire_sword = $VampireSword
@onready var vampire_sword_2 = $VampireSword2

var sword_amount

# Called when the node enters the scene tree for the first time.
func _ready():
	var temp_sword_amount = 0
	for sword in swordgroup.get_children():
		temp_sword_amount += 1
		sword.connect("sword_picked_up", count_sword)
	sword_amount = temp_sword_amount
	print(sword_amount)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func count_sword():
	sword_amount -= 1
	print(sword_amount)
	if sword_amount == 0:
		reveal_switch()
	
func reveal_switch():
	animation_player.play("Final_cutscene")
