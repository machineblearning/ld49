extends Spatial

signal next_level
signal reload_level

func _ready():
	pass

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("next_level")

func set_state(sid):
	pass
