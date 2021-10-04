extends Spatial

onready var anim_player = $AnimationPlayer
onready var bar = $GreenBar

func _ready():
	anim_player.play("empty_anim")
	bar.mesh.size = Vector3(8, 1, 2)
	pass

func set_value(val):
	var x = (val/100.0) * 8
	bar.mesh.size = Vector3(x, 1, 2)
	pass
