extends Area2D

@export var flow_dir: Vector2 = Vector2.RIGHT
@export var is_iced: bool = false
@export var angular_speed_deg: float = 90.0
@export var debug_color: Color = Color(1, 0, 0, 1)

var bodies_in_flow: Array[Node] = []

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node) -> void:
	print("player entered water")
	bodies_in_flow.append(body)

func _on_body_exited(body: Node) -> void:
	print("player left water")
	bodies_in_flow.erase(body)

func _physics_process(delta: float) -> void:
	if not is_iced:
		var angular_speed_rad := deg_to_rad(angular_speed_deg)
		flow_dir = flow_dir.rotated(angular_speed_rad * delta).normalized()

		var strength := 300.0
		for body in bodies_in_flow:
			_push_body(body, strength, delta)

	queue_redraw()

func _push_body(body: Node, strength: float, delta: float) -> void:
	var push := flow_dir * strength

	if body is RigidBody2D:
		body.apply_central_force(push)
	elif body is CharacterBody2D:
		body.velocity += push * delta
	elif "velocity" in body:
		body.velocity += push * delta

func _draw():
	var cs := $CollisionShape2D
	if cs == null or cs.shape == null:
		return

	var rect := cs.shape as RectangleShape2D
	if rect:
		var half := rect.size * 0.5

		# Corners in the RectangleShape2D's local space
		var p0 := Vector2(-half.x, -half.y)
		var p1 := Vector2( half.x, -half.y)
		var p2 := Vector2( half.x,  half.y)
		var p3 := Vector2(-half.x,  half.y)

		# Transform them to global space using the CollisionShape2D
		var gt: Transform2D = cs.global_transform
		var g0 := gt * p0
		var g1 := gt * p1
		var g2 := gt * p2
		var g3 := gt * p3

		# Convert back to this Area2D's local space for drawing
		var l0 := to_local(g0)
		var l1 := to_local(g1)
		var l2 := to_local(g2)
		var l3 := to_local(g3)

		# Draw the outline
		draw_line(l0, l1, debug_color, 2.0)
		draw_line(l1, l2, debug_color, 2.0)
		draw_line(l2, l3, debug_color, 2.0)
		draw_line(l3, l0, debug_color, 2.0)

	# Flow direction debug line
	if flow_dir.length() > 0:
		var dir := flow_dir.normalized()
		var end := dir * 200.0
		draw_line(Vector2.ZERO, end, Color.RED, 2.0)
