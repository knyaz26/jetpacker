extends Node

@onready var position_player = Vector2(0, 0)
@onready var score = 0
@onready var timer: Timer

@onready var enemy_scene = preload("res://game/enemy/enemy.tscn")

func _ready() -> void:
	enemy_spawn()


func _process(delta: float) -> void:
	pass

func reset():
	score = 0
	
func enemy_spawn():
	timer = Timer.new()
	add_child(timer)
	timer.start(7)
	timer.timeout.connect(func(): 
		var enemy_instance = enemy_scene.instantiate()
		get_tree().root.add_child(enemy_instance)
		var enemy_spawn_position = Vector2(400 * cos(randi_range(0, 360)), 400 * sin(randi_range(0, 360)))
		enemy_instance.global_position = enemy_spawn_position
		)
