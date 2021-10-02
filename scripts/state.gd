extends Node

class_name State

var change_state
var persistent_state
var animation_player
var is_facing_right = true

var velocity = Vector3()
var gravity: float = 4.0
var term_velocity: float = 8.0

func _physics_process(delta):
	print("- - - -")
	print("On floor? ", persistent_state.is_on_floor())
	print("fall velocity: ", persistent_state.velocity.y)
	print("State: ", persistent_state.state.id)
	
	#if persistent_state.is_on_floor():
	#	persistent_state.grounded = true
	#	persistent_state.velocity.y = 0.0
	
	##if not persistent_state.is_on_floor():	# in air
	#if not persistent_state.grounded:	# in air
	#	persistent_state.velocity.y -= self.gravity * delta
	#else:					# on floor
	#	#persistent_state.velocity.y = 0.0
	#	pass
	
	# always apply gravity
	#persistent_state.velocity.y -= self.gravity * delta
	persistent_state.velocity.y = -8.0
	# clamp fall movement
	#persistent_state.velocity.y = clamp(persistent_state.velocity.y, -term_velocity, 0.0)
	
	persistent_state.move_and_slide(persistent_state.velocity, Vector3.UP)
	#persistent_state.move_and_slide_with_snap(persistent_state.velocity, Vector3.DOWN * 32, Vector3.UP)

func setup(change_state, persistent_state, animation_player):
	self.change_state = change_state
	self.persistent_state = persistent_state
	self.animation_player = animation_player

func move_left():
	pass

func move_right():
	pass

func flip_sprite(is_right):
	is_facing_right = is_right
	persistent_state.sprite.flip_h = not is_facing_right
