extends Spatial

onready var player = $Player/KinematicBody
onready var goal = $Goal/Area
onready var victory_timer = $VictoryTimer

signal next_level
signal reload_level

func _ready():
	goal.connect("body_entered", self, "_on_goal_entered")

func _on_goal_entered(body):
	if body.is_in_group("player_group"):
		handle_level_complete()
func _on_PowerUp_collected(type_id):
	player.add_armor(type_id)

func _on_VictoryTimer_timeout():
	emit_signal("next_level")

func handle_level_complete():
	victory_timer.wait_time = 3.0
	victory_timer.connect("timeout", self, "_on_VictoryTimer_timeout")
	victory_timer.start()
	player.victory_sound.play()


