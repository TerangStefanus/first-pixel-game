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
	var flowers := preview.get_node("Flowers") as TileMapLayer
	var atlas := flowers.tile_set.get_source(0) as TileSetAtlasSource
	assert(atlas.get_tile_animation_frames_count(Vector2i.ZERO) == 4)
	assert(atlas.get_tile_animation_columns(Vector2i.ZERO) == 4)
	assert(flowers.get_used_cells().size() > 0)
	for direction in ["down", "left", "right", "up"]:
		var run_name := StringName("run_" + direction)
		assert(sprite.sprite_frames.get_frame_count(run_name) == 6)
		assert(is_equal_approx(sprite.sprite_frames.get_animation_speed(run_name), 12.5))
		var expected_ms := [80.0, 55.0, 125.0, 80.0, 55.0, 125.0]
		for index in range(6):
			assert(is_equal_approx(sprite.sprite_frames.get_frame_duration(run_name, index) * 80.0, expected_ms[index]))
			assert(sprite.sprite_frames.get_frame_texture(run_name, index).get_size() == Vector2(64, 64))
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
	print("PASS: four redrawn6-frame runs with80/55/125ms timing; Shift speed/run/walk/idle transitions; four-column animated flowers and populated TileMapLayer")
	preview.queue_free()
	quit(0)
