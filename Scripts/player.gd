extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -300.0
const SCREEN_BORDERS : Vector2 = Vector2(1920, 850)
var facing_right = true

var wind_force: int = 0
var water_force: Vector2 = Vector2.ZERO

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var crouch_shape = $crouchCollisionShape2D
@onready var standing_shape = $NormalCollisionShape2D
func _process(_delta: float) -> void:
	sprite_logic()
	
	#Reset position when out of screen
	if position.y < 0 || position.y >= SCREEN_BORDERS.y || position.x < 0 || position.x >= SCREEN_BORDERS.x:
		get_tree().reload_current_scene()
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	elif Input.is_action_pressed("crouch"):
		standing_shape.disabled = true
		crouch_shape.disabled = false
	else:
		standing_shape.disabled = false
		crouch_shape.disabled = true
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	horizontal_movement()
	var direction := get_input_direction().x
	if direction:
		velocity.x = direction * SPEED + wind_force
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED) + wind_force
	#handle water interactions 
	velocity += water_force
	water_force = Vector2.ZERO
	move_and_slide()

func sprite_logic():
	# Orientation
	animated_sprite.flip_h = not facing_right
	# crouch
	if Input.is_action_pressed("crouch"):
		animated_sprite.play("crouch")
		
	#Idle
	elif velocity == Vector2.ZERO and is_on_floor():
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
	if (!Input.is_action_pressed("crouch")):
		if Input.is_action_pressed("move_right"):
			dir.x += 1
		if Input.is_action_pressed("move_left"):
			dir.x -= 1
	return dir.normalized()
	
func change_wind_force(force: int):
	wind_force = force
	
