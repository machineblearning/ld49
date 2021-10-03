extends State

class_name FallingState

var id = "falling"

var move_speed: float = 6.0
var max_move_speed: float = 2.0
var inputX = 0

func _ready():	
	self.animation_player.play("falling_anim")
	#persistent_state.grounded = false

func _physics_process(delta):
	# Horizontal Movement
	# input movement
	persistent_state.velocity.x += inputX * move_speed * delta
	persistent_state.velocity.x = clamp(persistent_state.velocity.x, -max_move_speed, max_move_speed)
	
	# condition to transition to "idle" state
	if persistent_state.is_on_floor():
		# refresh stamina (landing)
		persistent_state.stamina = 100.0
		
		change_state.call_func("idle")

func move_left():
	self.flip_sprite(false)
	inputX = -1

func move_right():
	self.flip_sprite(true)
	inputX = 1

func action_glide():
	change_state.call_func("gliding")
	

func action_dodge():
	change_state.call_func("dodge")
	#change_state.call_func("hitstun")

func hurt():
	change_state.call_func("hitstun")
