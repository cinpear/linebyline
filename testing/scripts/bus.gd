extends Node2D

#unique scene oml this is so great :sob:
#i can just edit the script directly this is so nice :sob:

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	"""if NavigationManager.spawn_door_tag != null:
		on_spawn(NavigationManager.spawn_door_tag)"""
	if DialogueManager.npcs_dialogue_current["testing"] == 11:
		DialogueManager.npcs_dialogue_current["testing"] = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func on_spawn(door_tag):
	var door_path  = "door_bus"
	var door = get_node(door_path) as Door
	NavigationManager.spawn_player(door.spawn.global_position)
