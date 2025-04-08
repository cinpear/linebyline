extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	DialogueManager.photo_taken.connect(open)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func open() -> void:
	visible = true
	if DialogueManager.last_interacted_main_npc != null:
		$pad/lines.frame = DialogueManager.npcs_dialogue_current[DialogueManager.last_interacted_main_npc] - 1

func _on_check_pressed() -> void:
	visible = false
	DialogueManager.item_done[DialogueManager.last_interacted_main_npc] = true
	pass # Replace with function body.
