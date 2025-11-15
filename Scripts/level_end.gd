extends Area2D
class_name LevelEnd


func _on_body_entered(_body):
	Global.next_level()
