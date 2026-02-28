extends Node2D

@export var flow_dir: Vector2
@export var is_iced: bool = true
#@export var angular_speed_deg: float = 90.0
@export var water_color: Color = Color(0.029, 0.267, 1.0, 0.894)
@export var ice_color: Color = Color(0.416, 0.6, 1.0, 0.871)
@export var strength := 1050.0
var bodies_in_flow: Array[Node] = []


func _ready() -> void:
	$WaterFlow.body_entered.connect(_on_body_entered)
	$WaterFlow.body_exited.connect(_on_body_exited)
	#animation.play("default")
	melt()

func _on_body_entered(body: Node) -> void:
	#print("player entered water")
	bodies_in_flow.append(body)
	if body is CharacterBody2D:
		body.velocity /= 2 

func _on_body_exited(body: Node) -> void:
	#print("player left water")
	bodies_in_flow.erase(body)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Debug_1"):
		if is_iced:
			melt()
		else:
			freeze()

func _physics_process(delta: float) -> void:
	if not is_iced:
		#var angular_speed_rad := deg_to_rad(angular_speed_deg)
		#flow_dir = flow_dir.rotated(angular_speed_rad * delta).normalized()

		
		for body in bodies_in_flow:
			_push_body(body, strength, delta)

	queue_redraw()

func _push_body(body: Node, strength: float, delta: float) -> void:
	var push := flow_dir * strength

	if body is RigidBody2D:
		body.apply_central_force(push)
	elif body is CharacterBody2D:
		body.water_force += push * delta
		#body.velocity += push * delta
	elif "velocity" in body:
		body.velocity += push * delta

func melt():
	is_iced = false
	$IceBlock.process_mode = Node.PROCESS_MODE_DISABLED
	$WaterFlow.process_mode = Node.PROCESS_MODE_INHERIT
	$ColorRect.color = water_color
	$TextureRect.visible = true

func freeze():
	is_iced = true
	$WaterFlow.process_mode = Node.PROCESS_MODE_DISABLED
	$IceBlock.process_mode = Node.PROCESS_MODE_INHERIT
	$ColorRect.color = ice_color
	$TextureRect.visible = false
