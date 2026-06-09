extends CharacterBody2D

@export var speed: float = 120.0

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	anim.play("idle_down")

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down"
	)

	velocity = direction * speed
	move_and_slide()

	if direction == Vector2.ZERO:
		if anim.animation != "idle_down":
			anim.play("idle_down")
	else:
		if anim.animation != "walk_down":
			anim.play("walk_down")
