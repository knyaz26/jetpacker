extends Node2D

@onready var gravity_on = true
@onready var fireable = true
@onready var bullet_scene = preload("res://game/bullet/bullet.tscn")

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	check_input_and_fly(delta)
	check_input_and_move(delta)
	check_input_and_fire()
	check_where_player_looks()
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

func check_where_player_looks():
	if get_global_mouse_position().x > position.x:
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D/AnimatedSprite2D2.flip_h = false
		$AnimatedSprite2D/AnimatedSprite2D2.offset.x = 4
		$AnimatedSprite2D/AnimatedSprite2D2.look_at(get_global_mouse_position())
		$CPUParticles2D.position.x = -5
		$AnimatedSprite2D/AnimatedSprite2D2/firepoint.position.x = 10
	else:
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D/AnimatedSprite2D2.flip_h = true
		$AnimatedSprite2D/AnimatedSprite2D2.offset.x = -4
		$AnimatedSprite2D/AnimatedSprite2D2.look_at(get_global_mouse_position())
		$AnimatedSprite2D/AnimatedSprite2D2.rotation_degrees += 180
		$CPUParticles2D.position.x = 5
		$AnimatedSprite2D/AnimatedSprite2D2/firepoint.position.x = -10
	
func check_input_and_fire():
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and fireable:
		var bullet_instance = bullet_scene.instantiate()
		get_tree().root.add_child(bullet_instance)
		bullet_instance.position = $AnimatedSprite2D/AnimatedSprite2D2/firepoint.global_position
		fireable = false
		var tween = create_tween()
		tween.tween_callback(func(): fireable = true).set_delay(0.5)
	
	
