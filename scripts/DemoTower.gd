extends Spatial

onready var player = $Player/KinematicBody
onready var player_spatial = $Player
onready var goal = $Goal/Area
onready var victory_timer = $VictoryTimer

signal next_level
signal reload_level(state)

var level_state

func _ready():
	goal.connect("body_entered", self, "_on_goal_entered")
	player.connect("dead", self, "_on_player_death")
	print("load level in state ", level_state)

func _on_goal_entered(body):
	if body.is_in_group("player_group"):
		handle_level_complete()

func _on_PowerUp_collected(type_id):
	player.add_armor(type_id)

func _on_checkpoint_entered(body):
	if body.is_in_group("player_group"):
		level_state += 1

func _on_VictoryTimer_timeout():
	emit_signal("next_level")

func _on_player_death():
	print("DED")
	self.level_state = 1
	emit_signal("reload_level", level_state)
	pass

func handle_level_complete():
	victory_timer.wait_time = 3.0
	victory_timer.connect("timeout", self, "_on_VictoryTimer_timeout")
	victory_timer.start()
	player.victory_sound.play()

func set_state(sid):
	print("set level state to ", sid)
	self.level_state = sid
	
	if level_state == 0:
		player_spatial.transform.origin = Vector3(6,42,0)
	if level_state == 1:
		player_spatial.transform.origin = Vector3(6,7,0)


