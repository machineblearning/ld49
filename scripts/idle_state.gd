extends State

class_name IdleState

var id = "idle"

func _ready():
	#animation_player
	#persistent_state.sprite.visible = true
	pass

func _physics_process(delta):
	#persistent_state.velocity.y -= gravity * delta
	pass

func move_left():
	change_state.call_func("walk")

func move_right():
	change_state.call_func("walk")

func set_sprite():
	#persistent_state.sprite = $IdleSprite
	pass

func hide_sprite():
	#persistent_state.sprite.visible = false
	#$IdleSprite.visible = false
	pass


