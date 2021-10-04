extends KinematicBody

onready var anim_player = $AnimationPlayer

var velocity = Vector3()
var gravity: float = 4.0
var term_velocity: float = 8.0
var despawn_height
var lock = false

signal hit_player
signal delete_me(objRef)

func _ready():
	lock = false
	#self.connect("hit_player", self.get_parent(), "_on_hit_player")
	anim_player.connect("animation_finished", self, "_on_anim_complete")
	anim_player.play("falling_anim")
	despawn_height = -120

func _physics_process(delta):
	# gravity
	self.velocity.y -= self.gravity * delta
	self.velocity.y = clamp(self.velocity.y, -term_velocity, 0.0)
	
	# Apply forces
	var collision = move_and_collide(self.velocity * delta)
	if collision:
		if collision.collider.is_in_group("player_group"):
			_on_hit_player()
			lock = true


	# Despawn Condition
	if self.translation.y < despawn_height:
		self.queue_free()

func _on_anim_complete(anim_name):
	if anim_name == "break_anim":
		#self.queue_free()
		emit_signal("delete_me", self)

func _on_hit_player():
	if not lock:
		emit_signal("hit_player")
		anim_player.play("break_anim")
