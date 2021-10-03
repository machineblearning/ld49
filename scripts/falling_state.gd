extends State

class_name FallingState

var id = "falling"

var move_speed: float = 6.0
var max_move_speed: float = 2.0
var slow_down_speed: float = 2.0
var inputX = 0

func _ready():	
	persistent_state.collision_layer = 1
	self.animation_player.play("falling_anim")
	#persistent_state.grounded = false

func _physics_process(delta):
	# Horizontal Movement
	# input movement
	persistent_state.velocity.x += inputX * move_speed * delta
	persistent_state.velocity.x = clamp(persistent_state.velocity.x, -max_move_speed, max_move_speed)
	
	# approach zero "air resistance"
	if persistent_state.velocity.x < 0.0:	# if moving left (negative)
		persistent_state.velocity.x += slow_down_speed * delta
		persistent_state.velocity.x = clamp(persistent_state.velocity.x, -max_move_speed, 0.0)
	elif persistent_state.velocity.x > 0.0:	# if moving right (positive)
		persistent_state.velocity.x -= slow_down_speed * delta
		persistent_state.velocity.x = clamp(persistent_state.velocity.x, 0.0, max_move_speed)
	# clamp horizontal movement
	persistent_state.velocity.x = clamp(persistent_state.velocity.x, -max_move_speed, max_move_speed)
	
	# condition to transition to "idle" state
	if persistent_state.is_on_floor():
		# refresh stamina (landing)
		persistent_state.landing_sound.play()
		persistent_state.stamina = 100.0
		
		change_state.call_func("idle")

func move_left():
	self.flip_sprite(false)
	inputX = -1

func move_right():
	self.flip_sprite(true)
	inputX = 1

func action_glide(is_gliding):
	if is_gliding:
		change_state.call_func("gliding")
	else:
		pass
	

func action_dodge():
	change_state.call_func("dodge")
	#change_state.call_func("hitstun")

func hurt():
	change_state.call_func("hitstun")
