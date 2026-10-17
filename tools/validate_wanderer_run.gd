extends SceneTree

func _initialize() -> void:
	call_deferred("_validate")

func _validate() -> void:
	var scene := load("res://scenes/previews/wanderer_run_preview.tscn") as PackedScene
	assert(scene != null)
	var preview := scene.instantiate()
	root.add_child(preview)
	await physics_frame
	var player := preview.get_node("Wanderer64") as CharacterBody2D
	var sprite := player.get_node("AnimatedSprite2D") as AnimatedSprite2D
	for direction in ["down", "left", "right", "up"]:
		var run_name := StringName("run_" + direction)
		assert(sprite.sprite_frames.get_frame_count(run_name) == 6)
		assert(is_equal_approx(sprite.sprite_frames.get_animation_speed(run_name), 12.5))
		var expected_ms := [90.0, 90.0, 90.0, 90.0, 90.0, 90.0] if direction in ["down", "up"] else [80.0, 55.0, 125.0, 80.0, 55.0, 125.0]
		for index in range(6):
			assert(is_equal_approx(sprite.sprite_frames.get_frame_duration(run_name, index) * 80.0, expected_ms[index]))
			assert(sprite.sprite_frames.get_frame_texture(run_name, index).get_size() == Vector2(64, 64))
			if direction in ["down", "up"]:
				_validate_visible_palms(sprite.sprite_frames.get_frame_texture(run_name, index).get_image(), direction, index)
		Input.action_press("move_" + direction)
		Input.action_press("wanderer_run")
		for tick in range(3):
			await physics_frame
		assert(sprite.animation == run_name)
		assert(is_equal_approx(player.velocity.length(), player.run_speed))
		Input.action_release("wanderer_run")
		for tick in range(3):
			await physics_frame
		assert(sprite.animation == StringName("walk_" + direction))
		assert(is_equal_approx(player.velocity.length(), player.speed))
		Input.action_release("move_" + direction)
		for tick in range(3):
			await physics_frame
		assert(sprite.animation == StringName("idle_" + direction))
	print("PASS: six-pose runs; vertical 90ms / lateral 80-55-125ms timing; Shift speed/run/walk/idle transitions; woodland preview loads")
	preview.queue_free()
	quit(0)

# Regression for the reported clipped/disappearing hands. Check the rendered
# export, after body/backpack compositing, rather than only the arm source layer.
func _validate_visible_palms(image: Image, direction: String, frame: int) -> void:
	var palms := [
		[Vector2i(23, 43), Vector2i(40, 43)],
		[Vector2i(23, 43), Vector2i(36, 40)],
		[Vector2i(23, 42), Vector2i(36, 39)],
		[Vector2i(23, 43), Vector2i(40, 43)],
		[Vector2i(27, 40), Vector2i(40, 43)],
		[Vector2i(27, 39), Vector2i(40, 42)],
	]
	var offset_y := -2 if direction == "up" else 0
	for origin in palms[frame]:
		for y in range(3):
			for x in range(3):
				assert(image.get_pixel(origin.x + x, origin.y + offset_y + y).is_equal_approx(Color8(215, 155, 91)), "clipped palm in %s frame %d" % [direction, frame + 1])
