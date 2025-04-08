extends AnimatedSprite2D

class_name filler_item

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	#left 2400 right  1400
	#top bottom 1400 either side
	global_position.x = random(3800) - 2400
	global_position.y = random(2800) - 1400
	global_position = Vector2.ZERO
	#while frame != DialogueManager.npcs_dialogue_current["testing"] - 1:
		#frame = random(11)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#random int from 0 to num (including both)
func random(num):
	randomize()
	var RandomNum = randi() % (num + 1)
	return(RandomNum)
