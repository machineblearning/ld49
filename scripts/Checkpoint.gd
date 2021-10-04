extends Spatial

onready var area = $Area
onready var anim_player = $AnimationPlayer

var active: bool = false

func _ready():
	self.active = false
	anim_player.play("off_anim")
	area.connect("body_entered", self, "_on_checkpoint_entered")

func _on_checkpoint_entered(body):
	if not active and body.is_in_group("player_group"):
		self.active = true
		anim_player.play("on_anim")
