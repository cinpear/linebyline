extends Area2D

class_name interact_detection

var inZone = false

@export var space_interact = true
@export var click_interact = true
@export var scene_name = ""
@export var node_name = ""

func _on_body_entered(body: Node2D) -> void:
	if body is player:
		inZone = true
	pass # Replace with function body.

func _on_body_exited(body: Node2D) -> void:
	if body is player:
		inZone = false
	pass # Replace with function body.

func _process(_delta: float) -> void:
	if inZone and space_interact and Input.is_action_just_pressed("interact"):
		Global.signal_interact(node_name, scene_name)
		pass

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if inZone and click_interact and event.is_action_pressed("click"):
		Global.signal_interact(node_name, scene_name)
	pass # Replace with function body.
