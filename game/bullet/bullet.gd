extends Node2D

@onready var target = get_global_mouse_position()

func _ready() -> void:
	$Sprite2D.flip_h = !(get_global_mouse_position().x > global_position.x)

func _process(delta: float) -> void:
	move_towards_target(delta)

func move_towards_target(delta):
	if global_position != target:
		var direction = (target - position).normalized()
		position += direction * 300 * delta
		rotation = ((target - global_position).angle())
