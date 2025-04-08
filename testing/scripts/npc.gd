extends CharacterBody2D

#var inZone = false
var isChatting = false

#signal inRange
#signal charIsLeft
#signal charIsRight
signal interactChar

func _ready() -> void:
	Global.on_interact.connect(if_interacted)

func _process(_delta: float) -> void:
	if $interact_detection.inZone == true and Global.inputPrompts == true:
		$prompts.visible = true
	else:
		$prompts.visible = false

func if_interacted():
	if Global.interaced_node == $interact_detection.node_name:
		if Global.interacted_scene == $interact_detection.scene_name:
			interactChar.emit();
			pass

func _on_interact_char() -> void:
	Global.inputPrompts = false
	pass # Replace with function body.
