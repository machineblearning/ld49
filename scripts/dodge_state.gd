extends State

class_name DodgeState

var id = "dodge"

var dodge_cost = 30

func _ready():
	# check if enough stamina
	if persistent_state.stamina >= dodge_cost:
		# consume stamina
		persistent_state.stamina -= dodge_cost
		persistent_state.stamina = clamp(persistent_state.stamina, 0.0, 100.0)
	
		persistent_state.collision_layer = 8
		self.animation_player.play("dodge_anim")
		persistent_state.dodge_sound.play()
		
		self.dodge_timer.set_wait_time(0.4)
		self.dodge_timer.connect("timeout", self, "_on_dodge_timeout")
		self.dodge_timer.start()
	else: # no enough stam to dodge
		_on_dodge_timeout()

func _physics_process(delta):
	#persistent_state.velocity.y -= gravity * delta
	pass

func move_left():
	self.flip_sprite(false)
	#change_state.call_func("walk")

func move_right():
	self.flip_sprite(true)
	#change_state.call_func("walk")

func action_glide(is_gliding):
	pass

func action_dodge():
	#change_state.call_func("falling")
	pass

func hurt():
	pass
	#change_state.call_func("hitstun")

func _on_dodge_timeout():
	persistent_state.collision_layer = 1
	change_state.call_func("falling")
