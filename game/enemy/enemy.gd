extends CharacterBody2D

@onready var state = "active"
@onready var fireable = true
@onready var bullet_scene = preload("res://game/bullet/bullet.tscn")

func _ready():
	pass
	
func _process(delta: float):
	match state:
		"active":
			face_player()
			gun_aim()
			decide_and_shoot()
		"inactive":
			pass
	move_and_slide()
	
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

func decide_and_shoot():
	#checks if player is in range to even try to shoot.
	if GameManager.position_player.distance_to(global_position) < 250 and fireable:
		fireable = false
		var bullet_instance = bullet_scene.instantiate()
		bullet_instance.position = $AnimatedSprite2D2/firepoint.global_position
		bullet_instance.rot = $AnimatedSprite2D2.rotation
		bullet_instance.flip = $AnimatedSprite2D.flip_h
		bullet_instance.target = GameManager.position_player
		get_tree().root.add_child(bullet_instance)
		var tween = create_tween()
		tween.tween_callback(func(): fireable = true).set_delay(1)
