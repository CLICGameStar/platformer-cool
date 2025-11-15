extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -300.0
const BASE_POSITION : Vector2 = Vector2(75, 622)

var facing_right = true

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _process(_delta: float) -> void:
	sprite_logic()
	
	#Reset position on fall
	if position.y >= 856:
		position = BASE_POSITION
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	horizontal_movement()
	var direction := get_input_direction().x
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()

func sprite_logic():
	# Orientation
	animated_sprite.flip_h = not facing_right
	# Idle
	if velocity == Vector2.ZERO and is_on_floor():
		animated_sprite.play("idle")
	# Walk
	elif velocity.x != 0:
		animated_sprite.play("walk")
	else:
		animated_sprite.play("default")
	
func horizontal_movement():
	var input_x := get_input_direction().x
	
	if input_x > 0:
		facing_right = true
	if input_x < 0:
		facing_right = false

func get_input_direction() -> Vector2:
	var dir = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		dir.x += 1
	if Input.is_action_pressed("move_left"):
		dir.x -= 1
	return dir.normalized()
