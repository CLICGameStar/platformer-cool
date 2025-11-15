extends Node

const LEVELS : Array = ["res://Scenes/Levels/Main.tscn"]
var current_level: int = 0

func next_level():
	current_level = (current_level + 1) % LEVELS.size()
	get_tree().change_scene_to_file(LEVELS[current_level])
