extends Spatial

onready var anim_player = $AnimationPlayer

func _ready():
	#anim_player.play("three_anim")
	pass

func set_value(val):
	if val == 0:
		anim_player.play("zero_anim")
	elif val == 1:
		anim_player.play("one_anim")
	elif val == 2:
		anim_player.play("two_anim")
	elif val == 3:
		anim_player.play("three_anim")
