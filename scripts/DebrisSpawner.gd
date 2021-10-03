extends Spatial

onready var player = self.get_parent().get_node("Player/KinematicBody")
var debris = preload("res://scenes/entities/Debris.tscn")

var spawn_rate: float = 5 # objects per sec
var rng
export var rng_mean: float = 0.0
var rng_deviation: float = 7.0

func _ready():
	rng = RandomNumberGenerator.new()
	rng.randomize()
	
	$SpawnTimer.wait_time = 60 / ( 60 * spawn_rate)
	$SpawnTimer.connect("timeout", self, "_on_SpawnTimer_timeout")
	$SpawnTimer.start()
	#player.connect()
	pass

func _on_SpawnTimer_timeout():
	var d = debris.instance()
	var randX = rng.randfn(rng_mean, rng_deviation)
	d.translate(Vector3(randX, 0, 0))
	add_child(d)
	d.get_node("KinematicBody").connect("hit_player", self, "_on_hit_player")
	d.get_node("KinematicBody").connect("delete_me", self, "_on_delete_debris")

func _on_hit_player():
	print("signal")
	player.hurt()

func _on_delete_debris(objRef):
	objRef.queue_free()
