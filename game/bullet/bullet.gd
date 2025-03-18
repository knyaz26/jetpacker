extends Node2D

var target
var rot
var flip
var vel = Vector2(0, 0)

func _ready() -> void:
	$AnimatedSprite2D.flip_h = !(target.x > global_position.x)
	rotation = rot
	$AnimatedSprite2D.flip_h = flip
	$Timer.start(1.0)
	
func _process(delta: float) -> void:
	movement(delta)
	check_for_destroy_conditions()

func movement(delta):
	position += vel * delta
	if vel != Vector2(0, 0):
		position = position.move_toward(target + position , 300 * delta)
	else:
		position = position.move_toward(target , 300 * delta)

func check_for_destroy_conditions():
	pass

func _on_timer_timeout() -> void:
	$AnimatedSprite2D.play("bullet_collision")


func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
