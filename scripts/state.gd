extends Node

class_name State

var change_state
var persistent_state
#var sprite
var animation_player

var velocity = Vector3()
var gravity: float = 4.0

func _physics_process(_delta):
	print(persistent_state.velocity.x)
	print(persistent_state.state.id)
	persistent_state.move_and_slide(persistent_state.velocity, Vector3.UP)

func setup(change_state, persistent_state, animation_player):
	self.change_state = change_state
	self.persistent_state = persistent_state
	#self.sprite = sprite
	self.animation_player = animation_player

func move_left():
	pass

func move_right():
	pass

func set_sprite():
	pass

func hide_sprite():
	pass
