extends Control

var open = false
var take_photo = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	open = false
	$layout.visible = open
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if take_photo == false:
		$layout/take_photo.flip_v = false
	else:
		$layout/take_photo.flip_v = true

"""
	if $layout/area != null:
		if $layout/area.has_overlapping_bodies():
			$open.flip_h = true
		else: 
			$open.flip_h = false
			print("don't flip")
		pass
		
	pass
"""

func _on_open_pressed() -> void:
	open = !open
	$layout.visible = open
	pass # Replace with function body.


func _on_area_2d_body_entered(body: Node2D) -> void:
	take_photo = true
	if body is story_item:
		take_photo = true
		print("yes")
	pass # Replace with function body.


func _on_area_2d_body_exited(body: Node2D) -> void:
	take_photo = false
	if body is story_item:
		take_photo = false
		print("no")
	pass # Replace with function body.


func _on_take_photo_pressed() -> void:
	if take_photo:
		print("yay")
	DialogueManager.photo_taken.emit()
	$layout.visible = false
	#DialogueManager.item_done[DialogueManager.last_interacted_main_npc] = true
	pass # Replace with function body.
