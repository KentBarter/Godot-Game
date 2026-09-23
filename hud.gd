extends CanvasLayer

func update_score(score):
	$ScoreLabel.text = str(score)


# Showing a message
func show_message(text):
	$GameName.text = text
	$GameName.show()
	$MessageTimer.start()


# Showing the game over
func show_game_over():
	show_message("Game Over")
	await get_tree().create_timer(2.5).timeout
	$GameName.text = "2D Platformer"
	$GameName.show()
	$GameStartButton.show()


# Responding to the start button
func _on_game_start_button_pressed() -> void:
	print("BUTTON PRESSED")
	$GameStartButton.hide()
	get_tree().change_scene_to_file("res://main_level.tscn")


func _on_MessageTimer_timeout():
	$GameName.hide()
