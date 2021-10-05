extends State

class_name GlidingState

var id = "gliding"

var move_speed: float = 100.0 #32.0
var min_move_speed: float = 0.05
var max_move_speed: float = 20.0
var max_fall_speed: float = 8.0
var slow_down_speed: float = 12.0
var inputX: int = 0
var lock
var thrust_power: float = 1.0 #20.0 #1.0 #0.1
var max_thurst: float = 10 #-2.5
var stamina_cost: float = 1.0 #0.1

func _ready():
	persistent_state.collision_layer = 1
	lock = true
	self.animation_player.play("gliding_anim")

func _physics_process(delta):
	# consume stamina
	persistent_state.stamina -= stamina_cost
	persistent_state.stamina = clamp(persistent_state.stamina, 0.0, 100.0)
	
	# Horizontal Movement
	# input movement
	persistent_state.velocity.x += inputX * move_speed * delta
	# approach zero "air resistance"
	if persistent_state.velocity.x < 0.0:	# if moving left (negative)
		persistent_state.velocity.x += slow_down_speed * delta
		persistent_state.velocity.x = clamp(persistent_state.velocity.x, -max_move_speed, 0.0)
	elif persistent_state.velocity.x > 0.0:	# if moving right (positive)
		persistent_state.velocity.x -= slow_down_speed * delta
		persistent_state.velocity.x = clamp(persistent_state.velocity.x, 0.0, max_move_speed)
	# clamp horizontal movement
	persistent_state.velocity.x = clamp(persistent_state.velocity.x, -max_move_speed, max_move_speed)
	
	# Vertical Movement
	persistent_state.velocity.y += thrust_power
	persistent_state.velocity.y = clamp(persistent_state.velocity.y, -100, max_thurst)
	
	inputX = 0

func _process(_delta):
	if persistent_state.stamina <= 0.0:
		change_state.call_func("falling")

func move_left():
	self.flip_sprite(false)
	inputX = -1

func move_right():
	self.flip_sprite(true)
	inputX = 1

func action_glide(is_gliding):
	if not is_gliding:
		change_state.call_func("falling")
	else:
		pass

func action_dodge():
	change_state.call_func("dodge")

func hurt():
	change_state.call_func("hitstun")
