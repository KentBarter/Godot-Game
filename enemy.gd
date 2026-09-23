extends Actor

@onready var stomp_area: Area2D = $StompArea2D
@export var score := 100

func _ready() -> void:
	velocity.x = -speed.x

func _physics_process(delta: float) -> void:
	# Apply gravity
	velocity.y += gravity * delta

	# Turn around when hitting a wall
	if is_on_wall():
		velocity.x *= -1

	move_and_slide()


# Player enters the stomp area
func _on_StompArea2D_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		# Make sure the player is above the enemy
		if body.global_position.y < global_position.y:
			die()


# Player touches the enemy itself
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.die()


func die() -> void:
	queue_free()
