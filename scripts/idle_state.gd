extends State

class_name IdleState

var id = "idle"

var max_move_speed: float = 2.0
var slow_down_speed: float = 2.0

func _ready():
	persistent_state.collision_layer = 1
	self.animation_player.play("idle_anim")
	pass

func _physics_process(delta):
	# approach zero "air resistance"
	if persistent_state.velocity.x < 0.0:	# if moving left (negative)
		persistent_state.velocity.x += slow_down_speed * delta
		persistent_state.velocity.x = clamp(persistent_state.velocity.x, -max_move_speed, 0.0)
	elif persistent_state.velocity.x > 0.0:	# if moving right (positive)
		persistent_state.velocity.x -= slow_down_speed * delta
		persistent_state.velocity.x = clamp(persistent_state.velocity.x, 0.0, max_move_speed)
	# clamp horizontal movement
	persistent_state.velocity.x = clamp(persistent_state.velocity.x, -max_move_speed, max_move_speed)
	
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

