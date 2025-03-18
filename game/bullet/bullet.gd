extends Node2D

@onready var target = get_global_mouse_position()
var rot
var flip

func _ready() -> void:
	$Sprite2D.flip_h = !(target.x > global_position.x)
	rotation = rot
	$Sprite2D.flip_h = flip
	
func _process(delta: float) -> void:
	movement(delta)
	destroy()

func movement(delta):
	position = position.move_toward(target, 300 * delta)

func destroy():
	if position == target:
		queue_free()
