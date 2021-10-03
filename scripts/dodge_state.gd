extends State

class_name DodgeState

var id = "dodge"

var dodge_cost = 10

func _ready():	
	self.animation_player.play("dodge_anim")
	
	self.dodge_timer.set_wait_time(0.4)
	self.dodge_timer.connect("timeout", self, "action_dodge")
	self.dodge_timer.start()
	
	persistent_state.stamina -= dodge_cost

func _physics_process(delta):
	#persistent_state.velocity.y -= gravity * delta
	pass

func move_left():
	self.flip_sprite(false)
	#change_state.call_func("walk")

func move_right():
	self.flip_sprite(true)
	#change_state.call_func("walk")

func action_glide():
	pass

func action_dodge():
	change_state.call_func("falling")

func hurt():
	change_state.call_func("hitstun")
