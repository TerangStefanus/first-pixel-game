extends CharacterBody2D

@export var speed: float = 64.0
@export var run_speed: float = 104.0

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

var facing: StringName = &"down"

func _ready() -> void:
	if not InputMap.has_action("wanderer_run"):
		InputMap.add_action("wanderer_run")
		var key := InputEventKey.new()
		key.physical_keycode = KEY_SHIFT
		InputMap.action_add_event("wanderer_run", key)
	anim.play(&"idle_down")

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var running := Input.is_action_pressed("wanderer_run")
	velocity = direction * (run_speed if running else speed)
	move_and_slide()

	if direction == Vector2.ZERO:
		anim.play(StringName("idle_" + String(facing)))
		return

	if absf(direction.x) > absf(direction.y):
		facing = &"right" if direction.x > 0.0 else &"left"
	else:
		facing = &"down" if direction.y > 0.0 else &"up"
	anim.play(StringName(("run_" if running else "walk_") + String(facing)))
