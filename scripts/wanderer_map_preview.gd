extends Node2D

const SPAWN := Vector2(456, 312)

func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo and event.physical_keycode == KEY_R:
		$Wanderer64.position = SPAWN
		$Wanderer64.velocity = Vector2.ZERO
		get_viewport().set_input_as_handled()
