extends Node

var title = preload("res://scenes/screens/TitleScreen.tscn")
var level1 = preload("res://scenes/levels/DemoTower.tscn")
var end = preload("res://scenes/screens/VictoryScreen.tscn")

var sceneArray = [title, level1, end]
#onready var level1 = get_node("test world")
var currentScene
var sceneIndx: int = 0

func scene_load(indx, state):
	var tmpScene = sceneArray[indx].instance()
	self.remove_child(currentScene)
	currentScene = tmpScene
	currentScene.connect("reload_level", self, "_on_reload_level")
	currentScene.connect("next_level", self, "_on_next_level")
	self.add_child(currentScene)
	currentScene.set_state(state)

func _ready():
	scene_load(sceneIndx, 0)
	print("game loaded")

func _on_reload_level(state):
	print("level reloaded")
	scene_load(sceneIndx, state)
	pass

func _on_next_level():
	sceneIndx += 1
	if sceneIndx == sceneArray.size():
		sceneIndx = 0
	scene_load(sceneIndx, 0)
	pass
