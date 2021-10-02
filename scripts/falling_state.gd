extends State

class_name FallingState

var id = "falling"

func _ready():	
	self.animation_player.play("falling_anim")
	#persistent_state.grounded = false

func _physics_process(delta):
	# condition to transition to "idle" state
	#if persistent_state.grounded:
	if persistent_state.is_on_floor():
		change_state.call_func("idle")

	# condition to transition to "gliding" state
	#if false:
	#	change_state.call_func("gliding")

	# condition to transition to "dodge" state
	#if false:
	#	change_state.call_func("dodge")

func move_left():
	self.flip_sprite(false)
	#change_state.call_func("walk")

func move_right():
	self.flip_sprite(true)
	#change_state.call_func("walk")

func set_sprite():
	pass

func hide_sprite():
	pass
