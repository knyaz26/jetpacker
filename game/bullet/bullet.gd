extends Node2D

var target
var rot
var flip
var vel

func _ready() -> void:
	$Sprite2D.flip_h = !(target.x > global_position.x)
	rotation = rot
	$Sprite2D.flip_h = flip
	$Timer.start()
	
func _process(delta: float) -> void:
	movement(delta)
	check_for_destroy_conditions()

func movement(delta):
	position += vel * delta
	position = position.move_toward(target + position , 300 * delta)

func check_for_destroy_conditions():
	pass

func _on_timer_timeout() -> void:
	queue_free()
