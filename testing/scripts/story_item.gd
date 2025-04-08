extends CharacterBody2D

class_name story_item

@export var npcName = ""
@export var npcDialogueNumber = 0

# ^^^ npcdialoguenumber should be 1 above the corresponding dialogue index? i think

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$sparkles.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	visible = false
	if DialogueManager.last_interacted_main_npc == npcName:
		if DialogueManager.npcs_dialogue_current[npcName] == npcDialogueNumber:
			visible = true
			$item.frame = npcDialogueNumber - 1
	pass


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	$sparkles.visible = true
	pass # Replace with function body.


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	$sparkles.visible = false
	pass # Replace with function body.
