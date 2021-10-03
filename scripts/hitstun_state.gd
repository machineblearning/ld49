extends State

class_name HitstunState

var id = "hitstun"

func _ready():
	persistent_state.collision_layer = 8
	
	self.animation_player.play("hitstun_anim")
	self.hitstun_timer.set_wait_time(0.6)
	self.hitstun_timer.connect("timeout", self, "_on_hitstun_timeout")
	self.hitstun_timer.start()
	
	# take damage
	persistent_state.take_damage()

func _physics_process(_delta):
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
	pass

func hurt():
	#change_state.call_func("idle")
	pass

func _on_hitstun_timeout():
	#change_state.call_func("idle")
	#persistent_state.get_node("CollisionShape").e
	persistent_state.collision_layer = 1
	change_state.call_func("falling")
