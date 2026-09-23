extends StaticBody2D

@onready var stomp_area: Area2D = $StompArea2D
@export var score := 100

# Player touches the enemy itself
func _on_body_entered(body: Node2D) -> void:
	print("BODY ENTERED: ", body.name)
	if body.is_in_group("Player"):
		die()


func die() -> void:
	queue_free()
