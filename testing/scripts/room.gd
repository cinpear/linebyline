extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	"""if NavigationManager.spawn_door_tag != null:
		on_spawn(NavigationManager.spawn_door_tag)"""
	var spawn = Vector2.ZERO
	spawn[0] = -683
	spawn[1] = 66
	NavigationManager.spawn_player(spawn)
	
	"""
	#var test_sprite := filler_item.new()
	var test_sprite := Sprite2D.new()
	test_sprite.texture = load("res://assets/story_items/bag.PNG")
	$"y sort objects".add_child(test_sprite)
	"""
	
	make_filler()
	
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_spawn(door_tag):
	var door_path  = "y sort objects/door_" + door_tag
	var door = get_node(door_path) as Door
	NavigationManager.spawn_player(door.spawn.global_position)


#random int from 0 to num (including both)
func random(num):
	randomize()
	var RandomNum = randi() % (num + 1)
	return(RandomNum)

func make_filler():
	var filler_sprites = [
		load("res://assets/story_items/bag.PNG"),
		load("res://assets/story_items/beret.PNG"),
		load("res://assets/story_items/boba.PNG"),
		load("res://assets/story_items/cake.PNG"),
		load("res://assets/story_items/carton.PNG"),
		load("res://assets/story_items/chips.PNG"),
		load("res://assets/story_items/choco.PNG"),
		load("res://assets/story_items/doll.PNG"),
		load("res://assets/story_items/flower.PNG"),
		load("res://assets/story_items/pudding.PNG"),
		load("res://assets/story_items/stars.PNG"),
		load("res://assets/story_items/succulent.PNG")
	]
	
	for i in range(DialogueManager.npcs_dialogue_current["testing"] * 10):
		var frame = DialogueManager.npcs_dialogue_current["testing"] - 1
		while frame == DialogueManager.npcs_dialogue_current["testing"] - 1:
			frame = random(11)
		
		var sprite := Sprite2D.new()
		sprite.texture = filler_sprites[frame]
		$"y sort objects".add_child(sprite)
		sprite.y_sort_enabled = true
		
		sprite.global_position.x = random(3800) - 2400
		sprite.global_position.y = random(2800) - 1400
		sprite.scale.x = 1.25
		sprite.scale.y = sprite.scale.x
