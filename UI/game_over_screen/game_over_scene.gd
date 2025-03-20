extends Control

var pos

func _ready() -> void:
	position = pos

func _process(delta: float) -> void:
	update_scoreboard()
	check_for_input()
	
func check_for_input():
	if Input.is_key_pressed(KEY_M):
		queue_free()
		get_tree().change_scene_to_file("res://UI/Main_Menu/main_menu.tscn")
		GameManager.reset()

func update_scoreboard():
	$VBoxContainer/Label2.text = "score: " + str(GameManager.score)
