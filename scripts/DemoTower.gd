extends Spatial

onready var player = $Player/KinematicBody


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PowerUp_collected(type_id):
	player.add_armor(type_id)
	print("collected type: ", type_id)
	pass # Replace with function body.
