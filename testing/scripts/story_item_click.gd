extends Control

@export var npcName = "testing"
@export var npcDialogueNumber = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$item.visible = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	visible = false
	if DialogueManager.last_interacted_main_npc == npcName:
		if DialogueManager.npcs_dialogue_current[npcName] == npcDialogueNumber:
			visible = true
			$item.frame = npcDialogueNumber - 1
	pass

func _on_texture_button_button_down() -> void:
	DialogueManager.photo_taken.emit()
	$item.visible = false
	pass # Replace with function body.
