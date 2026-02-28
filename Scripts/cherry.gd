extends Node2D

const SPEED_MODIFICATOR = 2.75
const JUMP_MODIFICATOR = 2.00
const TIME = 4.25

func _ready() -> void:
	$CherryArea.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body.has_method("change_speed") and body.has_method("change_jump"):
		body.change_speed(SPEED_MODIFICATOR, TIME)
		body.change_jump(JUMP_MODIFICATOR, TIME)
		self.queue_free()
