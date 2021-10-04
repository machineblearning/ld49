extends State

class_name VictoryState

var id = "victory"

func _ready():
	persistent_state.collision_layer = 8 # 8: only platform collision; 0: no collision
	
	self.animation_player.play("victory_anim")

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
