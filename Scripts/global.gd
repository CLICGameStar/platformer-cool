extends Node

const LEVELS : Array = ["res://Scenes/Levels/Level1.tscn"]
var current_level: int = 0

func next_level_safe():
	call_deferred("next_level")

func next_level():
	current_level = (current_level + 1) % LEVELS.size()
	get_tree().change_scene_to_file(LEVELS[current_level])

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
