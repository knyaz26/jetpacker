extends CharacterBody2D

@onready var gravity_on = true
@onready var fireable = true
@onready var bullet_scene = preload("res://game/bullet/bullet.tscn")
@onready var health = 3
@onready var state = "alive"

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	game_manager_update()
	update_score()
	update_heart_state()
	match state:
		"alive":
			check_input_and_fly(delta)
			check_input_and_move(delta)
			check_input_and_fire()
			check_where_player_looks()
			apply_gravity(delta)
			move_and_slide()
		"dead":
			pass
	
func apply_gravity(delta):
	if gravity_on and velocity.y < 8000 * delta:
		velocity.y += 200 * delta
	
func check_input_and_fly(delta):
	if(Input.is_key_pressed(KEY_W) and velocity.y > -5000 * delta):
		gravity_on = false
		velocity.y -= 200 * delta
	else:
		gravity_on = true
		
func check_input_and_move(delta):
	if Input.is_key_pressed(KEY_D) and velocity.x < 5000 * delta:
		velocity.x += 200 * delta
	if Input.is_key_pressed(KEY_A) and velocity.x > -5000 * delta:
		velocity.x += -200 * delta

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
		$AnimatedSprite2D/AnimatedSprite2D2.play("fireing")
		var bullet_instance = bullet_scene.instantiate()
		bullet_instance.position = $AnimatedSprite2D/AnimatedSprite2D2/firepoint.global_position
		bullet_instance.rot = $AnimatedSprite2D/AnimatedSprite2D2.rotation
		bullet_instance.flip = $AnimatedSprite2D.flip_h
		bullet_instance.vel = velocity
		bullet_instance.target = get_local_mouse_position()
		get_tree().root.add_child(bullet_instance)
		fireable = false
		var tween = create_tween()
		tween.tween_callback(func(): fireable = true).set_delay(0.5)

func game_manager_update():
	GameManager.position_player = global_position
	
func _on_animated_sprite_2d_2_animation_finished() -> void:
	$AnimatedSprite2D/AnimatedSprite2D2.play("default")
	
func _on_animated_sprite_2d_animation_finished() -> void:
	$AnimatedSprite2D.play("default")
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	$AnimatedSprite2D.play("damaged")
	velocity += sign(area.get_parent().target) * 50
	health -= 1
	if !health:
		state = "dead"

func update_score():
	$UI/Label.text = "score: " + str(GameManager.score)

func update_heart_state():
	if health < 3:
		$UI/AnimatedSprite2D3.play("empty")
	if health < 2:
		$UI/AnimatedSprite2D2.play("empty")
	if health < 1:
		$UI/AnimatedSprite2D.play("empty")
