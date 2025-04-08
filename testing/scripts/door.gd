extends Area2D

class_name Door

@export var destination_scene : String
@export var destination_door : String
@export var bus = false

@onready var spawn = $spawn

func _ready() -> void:
	Global.on_interact.connect(if_interacted)
	
func if_interacted():
	if Global.interaced_node == $interact_detection.node_name:
		if Global.interacted_scene == $interact_detection.scene_name:
			NavigationManager.load_bus = bus
			NavigationManager.go_to_world(destination_scene, destination_door)

"""
func _on_body_entered(body: Node2D) -> void:
	if body is player:
		NavigationManager.go_to_world(destination_scene, destination_door)
		#lav pls make a global function that tps players yayayaya
	pass # Replace with function body.
"""
