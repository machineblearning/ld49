extends State

class_name IdleState

var id = "idle"

func _ready():
	self.animation_player.play("idle_anim")
	pass

func _physics_process(delta):
	#persistent_state.velocity.y -= gravity * delta
	
	# condition to transition to "falling" state
	#if not persistent_state.grounded:
	if not persistent_state.is_on_floor():
		change_state.call_func("falling")



func move_left():
	self.flip_sprite(false)
	change_state.call_func("walk")

func move_right():
	self.flip_sprite(true)
	change_state.call_func("walk")

func action_glide(is_gliding):
	pass

func action_dodge():
	pass

func hurt():
	change_state.call_func("hitstun")

