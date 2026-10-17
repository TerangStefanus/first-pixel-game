extends SceneTree

func _initialize() -> void:
	call_deferred("_validate")

func _validate() -> void:
	var packed := load("res://scenes/wanderer_64.tscn") as PackedScene
	if packed == null:
		push_error("Cannot load Wanderer scene")
		quit(1)
		return
	var player := packed.instantiate() as CharacterBody2D
	root.add_child(player)
	await physics_frame
	var sprite := player.get_node("AnimatedSprite2D") as AnimatedSprite2D
	var frames := sprite.sprite_frames
	for direction in ["down", "left", "right", "up"]:
		for prefix in ["idle_", "walk_"]:
			var name := StringName(prefix + direction)
			var walk_count := 8 if direction in ["left", "right"] else 4
			var expected := walk_count if prefix == "walk_" else 1
			if not frames.has_animation(name) or frames.get_frame_count(name) != expected:
				push_error("Missing animation or wrong frame count: " + name)
				quit(1)
				return
			for index in range(expected):
				if frames.get_frame_texture(name, index).get_size() != Vector2(64, 64):
					push_error("Wrong frame dimensions: " + name)
					quit(1)
					return
		var action := StringName("move_" + direction)
		var before := player.position
		Input.action_press(action)
		for tick in range(3):
			await physics_frame
		if sprite.animation != StringName("walk_" + direction) or player.position == before:
			push_error("Direction does not walk: " + direction)
			quit(1)
			return
		Input.action_release(action)
		for tick in range(3):
			await physics_frame
		if sprite.animation != StringName("idle_" + direction):
			push_error("Idle does not preserve facing: " + direction)
			quit(1)
			return
	var approved_body: Image = frames.get_frame_texture(&"idle_right", 0).get_image()
	for index in range(8):
		var right_image: Image = frames.get_frame_texture(&"walk_right", index).get_image()
		var left_image: Image = frames.get_frame_texture(&"walk_left", index).get_image()
		for y in range(64):
			for x in range(64):
				if not _same_visible_color(right_image.get_pixel(x, y), left_image.get_pixel(63 - x, y)):
					push_error("Side poses are not exact mirrors")
					quit(1)
					return
				if y < 46 and not _same_visible_color(right_image.get_pixel(x, y), approved_body.get_pixel(x, y)):
					push_error("Approved upper body changes in side walk")
					quit(1)
					return
				if y >= 54 and right_image.get_pixel(x, y).a != 0.0:
					push_error("Leg extends below approved base foot line")
					quit(1)
					return
	if absf(frames.get_animation_speed(&"walk_right") - 10.0) > 0.001:
		push_error("Incorrect side-walk timing")
		quit(1)
		return
	print("PASS: 4 directions; 8-frame side walks at100ms; approved upper body; original leg height; exact mirrors; movement and idle facing")
	player.queue_free()
	quit(0)

func _same_visible_color(a: Color, b: Color) -> bool:
	# Godot may extrude RGB into fully transparent pixels during texture import.
	return a.a == b.a and (a.a == 0.0 or a == b)
