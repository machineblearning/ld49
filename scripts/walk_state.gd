extends State

class_name WalkState

var id = "walk"

var move_speed: float = 16.0
var min_move_speed: float = 0.05
var max_move_speed: float = 2.0
var max_fall_speed: float = 8.0
var slow_down_speed: float = 12.0
var inputX: int = 0
var lock

func _ready():
	lock = true
	
	self.animation_player.play("walk_anim")

func _physics_process(delta):
	# left/right movement
	# input movement
	persistent_state.velocity.x += inputX * move_speed * delta
	# approach zero "air resistance"
	#if inputX == 0:
	if persistent_state.velocity.x < 0.0:	# if moving left (negative)
		persistent_state.velocity.x += slow_down_speed * delta
		persistent_state.velocity.x = clamp(persistent_state.velocity.x, -max_move_speed, 0.0)
	elif persistent_state.velocity.x > 0.0:	# if moving right (positive)
		persistent_state.velocity.x -= slow_down_speed * delta
		persistent_state.velocity.x = clamp(persistent_state.velocity.x, 0.0, max_move_speed)
	# clamp horizontal movement
	persistent_state.velocity.x = clamp(persistent_state.velocity.x, -max_move_speed, max_move_speed)
	
	## fall movement (gravity)
	#persistent_state.velocity.y -= gravity * delta
	## clamp fall movement
	#persistent_state.velocity.y = clamp(persistent_state.velocity.y, -max_fall_speed, max_fall_speed)
	
	# condition to return to "idle" state
	if lock and abs(persistent_state.velocity.x) > min_move_speed:
		lock = false
	if not lock and abs(persistent_state.velocity.x) < min_move_speed:
		persistent_state.velocity.x = 0.0
		lock = true
		change_state.call_func("idle")
	
	# condition to transition to "falling" state
	#if persistent_state.velocity.y > 0.0:
	if not persistent_state.is_on_floor():
		change_state.call_func("falling")
	
	inputX = 0

func move_left():
	#persistent_state.sprite.flip_h = true
	self.flip_sprite(false)
	if inputX == 1:
		inputX = 0
	else:
		inputX = -1

func move_right():
	#persistent_state.sprite.flip_h = false
	self.flip_sprite(true)
	if inputX == -1:
		inputX = 0
	else:
		inputX = 1

func action_glide():
	pass

func action_dodge():
	pass

func hurt():
	change_state.call_func("hitstun")
