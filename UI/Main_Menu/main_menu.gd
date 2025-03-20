extends Control


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_P):
		get_tree().change_scene_to_file("res://game/arena/arena.tscn")
		GameManager.reset_enemies = false
		GameManager.game_on = true
	if Input.is_key_pressed(KEY_S):
		get_tree().change_scene_to_file("res://UI/settings/settings.tscn")
	if Input.is_key_pressed(KEY_Q):
		get_tree().quit()


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://game/arena/arena.tscn")
	GameManager.game_on = true
	GameManager.reset_enemies = false


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/settings/settings.tscn")


func _on_button_3_pressed() -> void:
	get_tree().quit()
