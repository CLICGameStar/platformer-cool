extends Node2D

const SPAWN_DELAY = 25

@export var cherry_object: PackedScene
var spawned_cherry: Node2D
var spawn_counter: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_cherry()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if spawned_cherry == null:
		spawn_counter += delta
	elif not is_instance_valid(spawned_cherry):
		spawned_cherry = null
	
	if spawn_counter > SPAWN_DELAY:
		spawn_counter = 0
		spawn_cherry()

func spawn_cherry() -> void:
	spawned_cherry = cherry_object.instantiate() as Node2D
	add_child(spawned_cherry)
	spawned_cherry.position = Vector2.ZERO
