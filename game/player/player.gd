extends Node2D

@onready var gravity_on = true

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	check_input_and_fly(delta)
	check_input_and_move(delta)
	apply_gravity(delta)
	
func apply_gravity(delta):
	if gravity_on:
		position.y += 300 * delta
	
func check_input_and_fly(delta):
	if(Input.is_key_pressed(KEY_W)):
		gravity_on = false
		position.y -= 200 * delta
	else:
		gravity_on = true
		
func check_input_and_move(delta):
	if Input.is_key_pressed(KEY_D):
		position.x += 100 * delta
	if Input.is_key_pressed(KEY_A):
		position.x -= 100 * delta
