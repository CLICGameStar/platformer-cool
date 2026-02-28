extends Node2D

const SPAWN_DELAY = 25

enum Sides {
	LEFT,
	RIGHT
}

@export var cherry_object: PackedScene
@export var cherry: Sides
var spawned_cherry: Node2D
var spawn_counter: float = SPAWN_DELAY
var spring: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if spawned_cherry == null and spring:
		spawn_counter += delta
	elif not is_instance_valid(spawned_cherry):
		spawned_cherry = null
	
	if spawn_counter >= SPAWN_DELAY and spring:
		spawn_counter = 0
		spawn_cherry()

func spawn_cherry() -> void:
	spawned_cherry = cherry_object.instantiate() as Node2D
	add_child(spawned_cherry)
	spawned_cherry.position = Vector2.LEFT * 25 if cherry == Sides.LEFT else Vector2.RIGHT * 25 

func enter_spring() -> void:
	spring = true

func leave_spring() -> void:
	if spawned_cherry:
		spawned_cherry.queue_free()
		spawn_counter = SPAWN_DELAY
		spawned_cherry = null
		spring = false
