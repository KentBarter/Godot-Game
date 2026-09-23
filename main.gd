extends Node2D
# export(PackedScene) var mob_scene
var score

# taking in rand just in case
func _ready():
	randomize()

func new_game():
	score = 0
	$Hud.update_score(score)
	
	# load in the player
	
func game_over():
	$Hud.show_game_over()
