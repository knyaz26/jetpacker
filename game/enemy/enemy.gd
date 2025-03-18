extends CharacterBody2D

func _ready():
	pass
	
func _process(delta: float):
	face_player()
	
func face_player():
	if GameManager.position_player.x > global_position.x:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true
	
