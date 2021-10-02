extends State

class_name IdleState

var id = "idle"

func _ready():
	persistent_state.sprite.visible = false
	persistent_state.sprite = persistent_state.get_node("IdleSprite")
	persistent_state.sprite.visible = true
	
	self.animation_player.play("idle_anim")
	pass

func _physics_process(delta):
	#persistent_state.velocity.y -= gravity * delta
	pass

func move_left():
	self.flip_sprite(false)
	change_state.call_func("walk")

func move_right():
	self.flip_sprite(true)
	change_state.call_func("walk")

func set_sprite():
	#persistent_state.sprite = $IdleSprite
	pass

func hide_sprite():
	#persistent_state.sprite.visible = false
	#$IdleSprite.visible = false
	pass


