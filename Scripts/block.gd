extends Path2D


@export var loop = true
@export var speed = 5.0
@export var speed_scale = 1.0

@onready var path = $PathFollow2D
@onready var animation = $AnimationPlayer

var ratio =0
var midAnimRatio = 1
var start_point = 0

func _ready():
	path.progress =0

func _process(_delta: float) -> void:
	path.rotation =0
	if Input.is_action_just_pressed("Button_1") && !animation.is_playing():
		if path.progress_ratio == 1:
			animation.play("move", -1, -speed, true)
		else:
			animation.play("move", -1, speed, false)
		

		
	
	
	
#	if path.progress_ratio == midAnimRatio:
#		animation.pause()
#		midAnimRatio = (midAnimRatio +1) % 2
#		print(midAnimRatio)
#	if Input.is_action_just_pressed("Button_1"):
#		animation.play("move")
#		path.progress_ratio=ratio
			
	
		
