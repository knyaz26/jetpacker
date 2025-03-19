extends CharacterBody2D

@onready var state = "alive"
@onready var fireable = true
@onready var bullet_scene = preload("res://game/bullet/bullet.tscn")
@onready var health = 3

func _ready():
	pass
	
func _process(delta: float):
	match state:
		"alive":
			face_player()
			gun_aim()
			decide_and_shoot()
			move_and_slide()
		"dead":
			play_death_animation()
	
func face_player():
	if GameManager.position_player.x > global_position.x:
		$AnimatedSprite2D.flip_h = false
		$CPUParticles2D.position.x = -5
		$AnimatedSprite2D2.flip_h = false
		$AnimatedSprite2D2.offset.x = 2
		$AnimatedSprite2D2/firepoint.position.x = 8
	else:
		$AnimatedSprite2D.flip_h = true
		$CPUParticles2D.position.x = 5
		$AnimatedSprite2D2.flip_h = true
		$AnimatedSprite2D2.offset.x = -2
		$AnimatedSprite2D2/firepoint.position.x = -8
	
func gun_aim():
	$AnimatedSprite2D2.look_at(GameManager.position_player)
	if !GameManager.position_player.x > global_position.x:
		$AnimatedSprite2D2.rotation_degrees += 180

#if you ever come back to this code to figure out whats going on, i dont know either.
func decide_and_shoot():
	if GameManager.position_player.distance_to(global_position) < 200 and fireable:
		$AnimatedSprite2D2.play("fired")
		fireable = false
		var bullet_instance = bullet_scene.instantiate()
		bullet_instance.position = $AnimatedSprite2D2/firepoint.global_position
		bullet_instance.rot = $AnimatedSprite2D2.rotation
		bullet_instance.flip = $AnimatedSprite2D.flip_h
		var aim_point = GameManager.position_player + Vector2(
		randi_range(-global_position.distance_to(GameManager.position_player) / 4, global_position.distance_to(GameManager.position_player) / 3),
		randi_range(-global_position.distance_to(GameManager.position_player) / 4, global_position.distance_to(GameManager.position_player) / 3))
		bullet_instance.target = aim_point + (aim_point - global_position).normalized() * 1000
		#idk why but this only apples to one dummy.
		#bullet_instance.rot = (bullet_instance.position).angle_to(bullet_instance.target)
		get_tree().root.add_child(bullet_instance)
		var tween = create_tween()
		tween.tween_callback(func(): fireable = true).set_delay(2)


func _on_animated_sprite_2d_2_animation_finished() -> void:
	$AnimatedSprite2D2.play("default")
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	$AnimatedSprite2D.play("damage")
	velocity += sign(GameManager.position_player - global_position) * -30
	health -= 1
	if !health:
		state = "dead"
		GameManager.score += 1
	
func _on_animated_sprite_2d_animation_finished() -> void:
	$AnimatedSprite2D.play("default")

func play_death_animation():
	$AnimatedSprite2D.play("dead")
	$AnimatedSprite2D2.visible = false
	$CPUParticles2D.visible = false
