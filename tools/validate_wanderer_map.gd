extends SceneTree

func _initialize() -> void:
	create_timer(10.0).timeout.connect(_timeout)
	call_deferred("_validate")

func _timeout() -> void:
	push_error("Map validation timed out before completion")
	quit(1)

func _step(frames: int) -> void:
	for tick in range(frames):
		await physics_frame

func _validate() -> void:
	var scene := (load("res://scenes/previews/wanderer_run_preview.tscn") as PackedScene).instantiate()
	root.add_child(scene)
	await _step(2)
	var ground := scene.get_node("Ground") as TileMapLayer
	print("Ground bounds: ", ground.get_used_rect(), "; cells: ", ground.get_used_cells().size())
	assert(ground.get_used_rect() == Rect2i(0, 0, 40, 28))
	assert(ground.get_used_cells().size() == 40 * 28)
	assert(ground.tile_set.tile_size == Vector2i(32, 32))
	assert(ground.get_cell_atlas_coords(Vector2i(20, 15)) == Vector2i(3, 2))
	assert(ground.get_cell_atlas_coords(Vector2i(15, 10)).y == 0)
	var player := scene.get_node("Wanderer64") as CharacterBody2D
	for start in [Vector2(656, 496), Vector2(520, 320)]:
		player.position = start
		Input.action_press("move_right")
		Input.action_press("wanderer_run")
		await _step(15)
		Input.action_release("move_right")
		Input.action_release("wanderer_run")
		assert(player.position.x > start.x + 18.0, "Dirt and grass must both be walkable")
	player.position = Vector2(390, 370)
	Input.action_press("move_up")
	Input.action_press("wanderer_run")
	await _step(30)
	Input.action_release("move_up")
	assert(player.position.y >= 347 and player.position.y < 360, "Tree trunk must block movement")
	Input.action_release("wanderer_run")
	player.position = Vector2(390, 310)
	await process_frame
	await process_frame
	var landmark: StaticBody2D
	for node in scene.get_children():
		if node is StaticBody2D and node.position == Vector2(390, 340):
			landmark = node
	assert(landmark != null)
	assert(landmark.get_node("Sprite2D").self_modulate.a < 0.5)
	player.position = Vector2(656, 496)
	await process_frame
	assert(landmark.get_node("Sprite2D").self_modulate.a == 1.0)
	Input.action_press("wanderer_run")
	for sample in [[Vector2(8, 496), "move_left"], [Vector2(1272, 496), "move_right"], [Vector2(640, 10), "move_up"], [Vector2(640, 886), "move_down"]]:
		player.position = sample[0]
		Input.action_press(sample[1])
		await _step(18)
		Input.action_release(sample[1])
		assert(player.position.x >= 4.9 and player.position.x <= 1275.1)
		assert(player.position.y >= 7.9 and player.position.y <= 894.1)
	Input.action_release("wanderer_run")
	var reset := InputEventKey.new()
	reset.physical_keycode = KEY_R
	reset.pressed = true
	scene._unhandled_key_input(reset)
	assert(player.position == Vector2(656, 496))
	var camera := player.get_node("Camera2D") as Camera2D
	assert(camera.limit_left == 0 and camera.limit_right == 1280)
	assert(camera.limit_top == 0 and camera.limit_bottom == 896)
	assert(camera.zoom == Vector2.ONE)
	reset.physical_keycode = KEY_Z
	scene._unhandled_key_input(reset)
	assert(camera.zoom == Vector2(2, 2))
	scene._unhandled_key_input(reset)
	assert(camera.zoom == Vector2.ONE)
	reset.physical_keycode = KEY_H
	scene._unhandled_key_input(reset)
	assert(not scene.get_node("UI").visible)
	scene._unhandled_key_input(reset)
	assert(scene.get_node("UI").visible)
	assert(root.content_scale_stretch == Window.CONTENT_SCALE_STRETCH_INTEGER)
	assert(scene.get_node("UI/HUD").paths.size() > 0)
	print("PASS: 32px woodland; grass/dirt traversal; tree and boundary collisions; reset, 1x/2x zoom, integer scaling and live HUD")
	scene.queue_free()
	quit()
