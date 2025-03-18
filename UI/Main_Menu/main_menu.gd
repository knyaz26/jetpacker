extends Control


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_P):
		get_tree().change_scene_to_file("res://game/arena/arena.tscn")
	if Input.is_key_pressed(KEY_S):
		pass #add settings here.
	if Input.is_key_pressed(KEY_Q):
		get_tree().quit()


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://game/arena/arena.tscn")


func _on_button_2_pressed() -> void:
	pass # Replace with settings menu.


func _on_button_3_pressed() -> void:
	get_tree().quit()
