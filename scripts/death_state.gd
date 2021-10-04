extends State

class_name DeathState

var id = "death"

func _ready():
	persistent_state.collision_layer = 8 # 8: only platform collision; 0: no collision
	
	persistent_state.death_sound.play()
	self.animation_player.play("death_anim")
	self.hitstun_timer.set_wait_time(2.0)
	self.hitstun_timer.connect("timeout", self, "_on_death_timeout")
	self.hitstun_timer.start()

func _physics_process(_delta):
	pass

func move_left():
	pass

func move_right():
	pass

func action_glide(is_gliding):
	pass

func action_dodge():
	pass

func hurt():
	pass

func _on_death_timeout():
	persistent_state.emit_signal("dead")
	
