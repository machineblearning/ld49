extends KinematicBody

class_name PersistentState

var state
var state_factory
var sprite

signal dead

# Audio
onready var stamina_refill_sound = $StaminaRefillSoundPlayer
onready var spawn_sound = $SpawnSoundPlayer
onready var landing_sound = $LandingSoundPlayer
onready var deploy_sound = $DeploySoundPlayer
onready var dodge_sound = $DodgeSoundPlayer
onready var damage_sound = $DamageSoundPlayer
onready var hat_damage_sound = $HatDamageSoundPlayer
onready var death_sound = $DeathSoundPlayer
onready var victory_sound = $VictorySoundPlayer

# UI
onready var health_bar = $UI/HealthBar
onready var armor_bar = $UI/ArmorBar
onready var stamina_bar = $UI/StaminaBar

# Hat Armor
onready var hat1 = $Hat1
onready var hat2 = $Hat2
onready var hat3 = $Hat3

onready var death_timer = $DeathTimer

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
	
	spawn_sound.play()
	update_health_ui(3)
	set_active_all_hats(false)
	add_armor(4)
	
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
	
	# UI update
	update_stamina_ui(self.stamina)

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
		hat_damage_sound.play()
		self.armor -= 1
		if self.armor == 0:
			hat1.set_active(false)
		elif self.armor == 1:
			hat2.set_active(false)
		elif self.armor == 2:
			hat3.set_active(false)
		update_armor_ui(self.armor)
	elif self.health > 0: # handle health decrease
		damage_sound.play()
		self.health -= 1
		update_health_ui(self.health)
#	if self.health <= 0: # handle death
#		handle_death()

func add_armor(type_id):
	if self.armor < 3:
		self.armor += 1
		update_armor_ui(self.armor)
		if self.armor == 1:
			hat1.set_active(true)
			hat1.setup(type_id)
		elif self.armor == 2:
			hat2.set_active(true)
			hat2.setup(type_id)
		elif self.armor == 3:
			hat3.set_active(true)
			hat3.setup(type_id)

	

func set_active_all_hats(is_active):
	hat1.set_active(is_active)
	hat2.set_active(is_active)
	hat3.set_active(is_active)

func update_armor_ui(val):
	armor_bar.set_value(val)

func update_health_ui(val):
	health_bar.set_value(val)

func update_stamina_ui(val):
	stamina_bar.set_value(val)

#func handle_death():
#	change_state("death")
	#state.animation_player.play("death_anim")
	#self.death_timer.set_wait_time(3.0)
	#self.death_timer.connect("timeout", self, "_on_death_timeout")
	#self.death_timer.start()

#func _on_death_timeout():
#	emit_signal("dead")


