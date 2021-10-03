extends KinematicBody

class_name PersistentState

var state
var state_factory
var sprite

var velocity = Vector3()
var health: int
var armor: int
var stamina: float

func _ready():
	self.health = 3
	self.armor = 0
	self.stamina = 100.0
	self.sprite = $Sprite
	state_factory = StateFactory.new()
	change_state("idle")

func _physics_process(_delta):
	#if not is_on_floor():	# in air
	#	self.velocity.y -= state.gravity * delta
	#else:					# on floor
	#	self.velocity.y = 0.0
	pass

# Input code was placed here for tutorial purposes.
func _process(_delta):
	# Movement
	if Input.is_action_pressed("action_left"):
		move_left()
	elif Input.is_action_pressed("action_right"):
		move_right()
	
	# Glide
	if Input.is_action_just_pressed("action_glide"):
		action_glide()
	if Input.is_action_just_released("action_glide"):
		action_glide()
	
	# Dodge
	if Input.is_action_just_pressed("action_dodge"):
		action_dodge()
	#if Input.is_action_just_released("action_dodge"):
	#	action_dodge()

func move_left():
	state.move_left()

func move_right():
	state.move_right()

func action_glide():
	state.action_glide()

func action_dodge():
	state.action_dodge()

func change_state(new_state_name):
	# clean up current state before transition
	
	# setup new state
	if state != null:
		#state.hide_sprite()
		state.queue_free()
	state = state_factory.get_state(new_state_name).new()
	state.setup(funcref(self, "change_state"), self, $AnimationPlayer, $HitstunTimer, $DodgeTimer)
	state.name = "current_state"
	#state.set_sprite()
	
	# transition to new state
	add_child(state)

