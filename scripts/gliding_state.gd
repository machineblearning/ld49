extends State

class_name GlidingState

var id = "gliding"

func _ready():	
	self.animation_player.play("gliding_anim")

func _physics_process(delta):
	#persistent_state.velocity.y -= gravity * delta
	pass

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
