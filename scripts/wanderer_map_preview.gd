extends Node2D

const SPAWN := Vector2(656, 496)
const WORLD_SIZE := Vector2(1280, 896)

func _ready() -> void:
	var window := get_window()
	window.content_scale_size = Vector2i(640, 360)
	window.content_scale_mode = Window.CONTENT_SCALE_MODE_VIEWPORT
	window.content_scale_aspect = Window.CONTENT_SCALE_ASPECT_KEEP
	window.content_scale_stretch = Window.CONTENT_SCALE_STRETCH_INTEGER

func _unhandled_key_input(event: InputEvent) -> void:
	if not event is InputEventKey or not event.pressed or event.echo:
		return
	match event.physical_keycode:
		KEY_R:
			$Wanderer64.position = SPAWN
			$Wanderer64.velocity = Vector2.ZERO
		KEY_Z:
			var camera := $Wanderer64/Camera2D as Camera2D
			camera.zoom = Vector2(2, 2) if camera.zoom.x == 1.0 else Vector2.ONE
		KEY_H:
			$UI.visible = not $UI.visible
		_:
			return
	get_viewport().set_input_as_handled()
