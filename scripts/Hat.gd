extends Spatial

export var type: int = 1

signal collected(type_id)
var lock = false

onready var anim_player = $AnimationPlayer
onready var sprite = $Sprite3D
onready var body = $Sprite3D/StaticBody


func _ready():
	lock = false
	setup(self.type)

func _process(_delta):
	#print("layer: ", self.body.collision_layer)
	pass

func setup(type):
	self.type = type
	# set sprite via animation
	if type == 1:	# straw hat		MUGIWARAAAAAA!!!!
		anim_player.play("type1")
	if type == 2:	# tophat
		anim_player.play("type2")
	if type == 3:	# cheese head
		anim_player.play("type3")
	if type == 4:	# baseball cap
		anim_player.play("type4")

func flip(b):
	sprite.flip_h = not b

func set_active(is_active):
	if is_active:
		self.show()
		self.body.collision_layer = 1
	else:
		self.hide()
		self.body.collision_layer = 8
	pass
