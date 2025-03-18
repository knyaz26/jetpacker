extends CharacterBody2D

func _ready():
	pass
	
func _process(delta: float):
	face_player()
	
func face_player():
	if GameManager.position_player.x > global_position.x:
		$AnimatedSprite2D.flip_h = false
		$CPUParticles2D.position.x = -5
		$AnimatedSprite2D2.flip_h = false
		$AnimatedSprite2D2.offset.x = 2
	else:
		$AnimatedSprite2D.flip_h = true
		$CPUParticles2D.position.x = 5
		$AnimatedSprite2D2.flip_h = true
		$AnimatedSprite2D2.offset.x = -2
	
