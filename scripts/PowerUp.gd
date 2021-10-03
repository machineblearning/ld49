extends Spatial

export var type: int = 1

signal collected(type_id)
var lock = false
onready var anim_player = $AnimationPlayer


func _ready():
	lock = false
	setup(self.type)

func _on_Area_body_entered(body):
	if body.is_in_group("player_group"):	# check if body is player
		if not lock:	# only collect once
			# item is collected
			lock = true
			emit_signal("collected", self.type)
			self.queue_free()

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
