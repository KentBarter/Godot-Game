extends Actor

@export var stomp_impulse := 600.0

func _ready() -> void:
	$AnimatedSprite2D.play("idle")

func _physics_process(delta: float) -> void:
	print(position)
	# Apply gravity
	velocity.y += gravity * delta

	# Stop upward movement when the jump button is released
	var is_jump_interrupted := (
		Input.is_action_just_released("ui_accept")
		and velocity.y < 0.0
	)

	var direction := get_direction()

	# Change the player's look direction
	if direction.x == -1:
		$AnimatedSprite2D.flip_h = true
	elif direction.x == 1:
		$AnimatedSprite2D.flip_h = false

	# Calculate movement
	velocity = calculate_move_velocity(
		velocity,
		direction,
		speed,
		is_jump_interrupted
	)

	# Move the CharacterBody2D
	move_and_slide()


func get_direction() -> Vector2:
	return Vector2(
		Input.get_axis("move_left", "move_right"),
		-1.0 if is_on_floor()
		and Input.is_action_just_pressed("ui_accept")
		else 0.0
	)


func calculate_move_velocity(
	linear_velocity: Vector2,
	direction: Vector2,
	move_speed: Vector2,
	is_jump_interrupted: bool
) -> Vector2:
	var new_velocity := linear_velocity

	new_velocity.x = move_speed.x * direction.x

	if direction.y != 0.0:
		new_velocity.y = move_speed.y * direction.y

	if is_jump_interrupted:
		new_velocity.y = 0.0

	return new_velocity


func calculate_stomp_velocity(
	linear_velocity: Vector2,
	stomp_impulse: float
) -> Vector2:
	var stomp_jump := (
		-speed.y
		if Input.is_action_pressed("ui_accept")
		else -stomp_impulse
	)

	return Vector2(linear_velocity.x, stomp_jump)


func _on_stomp_detector_area_entered(area: Area2D) -> void:
	velocity = calculate_stomp_velocity(velocity, stomp_impulse)


func _on_enemy_detector_body_entered(body: PhysicsBody2D) -> void:
	die()


func die() -> void:
	queue_free()
