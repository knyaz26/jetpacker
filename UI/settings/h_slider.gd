extends HSlider


func _ready() -> void:
	value_changed.connect(func(value):
		AudioServer.set_bus_volume_db(0, value)
		if value < -70:
			AudioServer.set_bus_mute(0, true)
		else:
			AudioServer.set_bus_mute(0, false)
	)


func _process(delta: float) -> void:
	pass
