extends KinematicBody

class_name PersistentState

var state
var state_factory
var sprite

onready var landing_sound = $LandingSoundPlayer
onready var deploy_sound = $DeploySoundPlayer
onready var dodge_sound = $DodgeSoundPlayer

onready var hat1 = $Hat1
onready var hat2 = $Hat2
onready var hat3 = $Hat3

var velocity = Vector3()
var health: int
var armor: int
var stamina: float

func _ready():
	
	self.health = 3
	self.armor = 3
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
		action_glide(true)
	if Input.is_action_just_released("action_glide"):
		action_glide(false)
	
	# Dodge
	if Input.is_action_just_pressed("action_dodge"):
		action_dodge()
	#if Input.is_action_just_released("action_dodge"):
	#	action_dodge()

func move_left():
	state.move_left()
	flip_hats(false)

func move_right():
	state.move_right()
	flip_hats(true)

func action_glide(is_gliding):
	state.action_glide(is_gliding)

func action_dodge():
	state.action_dodge()

func hurt():
	state.hurt()

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

func flip_hats(b):
	hat1.flip(b)
	hat2.flip(b)
	hat3.flip(b)

func take_damage():
	if self.armor > 0: # handle armor decrease
		self.armor -= 1
		if self.armor == 0:
			hat1.set_active(false)
		elif self.armor == 1:
			hat2.set_active(false)
		elif self.armor == 2:
			hat3.set_active(false)
		update_armor_ui(self.armor)
	elif self.health > 0: # handle health decrease
		#self.health -= 1
		update_health_ui(self.health)

func add_armor(type_id):
	if self.armor < 3:
		self.armor += 1
		if self.armor == 1:
			hat1.set_active(true)
			hat1.setup(type_id)
		elif self.armor == 2:
			hat2.set_active(true)
			hat2.setup(type_id)
		elif self.armor == 3:
			hat3.set_active(true)
			hat3.setup(type_id)
	

func update_armor_ui(val):
	pass

func update_health_ui(val):
	pass


