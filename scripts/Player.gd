#extends Spatial
extends KinematicBody

signal died
signal goal

var moveSpeed: float = 8.0
var floatSpeed: float = 1.0
var gravity: float = 32.0
#var gravity: float = 15.0


var falling: bool = false
var gliding: bool = false
var running: bool = false

var alive: bool = false
var goal: bool = false

var health: int = 3
var armor: int = 0
var stamina: float = 100.0

var velocity = Vector3()

onready var camera = get_node("CameraPlayer")

func reset():
	emit_signal("died")
	alive = true

func goal():
	emit_signal("goal")
	goal = false

func _ready():
	alive = true
	#$AnimationPlayer.set_current_animation("run")
	#$AnimationPlayer.play()

func _process(_delta):
	if not alive:
		reset()
	
	if goal:
		goal()
	
	if falling:
		#$AnimationPlayer.stop(false)
		pass
	else:
		pass
		#$AnimationPlayer.play()
	


func _physics_process(delta):
	
	if is_on_floor():
		falling = false
		gliding = false
	else:
		falling = true
	
	velocity.x = 0
	velocity.z = 0
	var input = Vector3()
	
	if Input.is_action_pressed("action_right"):
		input.x += 1
	if Input.is_action_pressed("action_left"):
		input.x -= 1
	if Input.is_action_pressed("action_glide"):
		gliding = true
	#if Input.is_action_pressed("move_forward"):
	#	input.z -= 1
	#if Input.is_action_pressed("move_backward"):
	#	input.z += 1
	input = input.normalized()
	
	var direction = transform.basis.z * input.z + transform.basis.x * input.x
	velocity.x = direction.x * moveSpeed
	velocity.z = direction.z * moveSpeed
	if falling:
		if gliding:
			velocity.y -= floatSpeed * delta
		else:
			velocity.y -= gravity * delta

	
	velocity = move_and_slide(velocity, Vector3.UP)

var rot_x = 0
var rot_y = 0
export(float, 0.00001, 0.01) var LOOK_SPEED = 0.001

func _input(event):
	if event is InputEventMouseMotion and event.button_mask & 1:
		rot_x += -1*event.relative.x * LOOK_SPEED
		rot_y += -1*event.relative.y * LOOK_SPEED
		transform.basis = Basis()
		rotate_object_local(Vector3(0,1,0), rot_x) # first rotate x
		rotate_object_local(Vector3(1,0,0), rot_y) # then rotate y


func _on_Goal_Area_body_shape_entered(body_id, body, body_shape, local_shape):
	if alive:
		if body_id == self.get_instance_id():
			goal = true
			print("Goal!")


func _on_Death_Area_body_shape_entered(body_id, body, body_shape, local_shape):
	if alive:
		if body_id == self.get_instance_id():
			alive = false
