class_name StateFactory

var states

func _init():
	states = {
		"idle": IdleState,
		"walk": WalkState,
		"falling": FallingState,
		"gliding": GlidingState,
		"dodge": DodgeState,
		"hitstun": HitstunState
}

func get_state(state_name):
	if states.has(state_name):
		return states.get(state_name)
	else:
		printerr("No state ", state_name, " in state factory!")
