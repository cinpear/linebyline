extends Node2D

var gacha_item_list = []

var t = 0.0
@export var gacha_type: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(8):
		gacha_item_list.append(i)
	$CanvasLayer/gacha_screen.frame = 0
	$CanvasLayer.visible = false
	print(gacha_item_list.size())
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$CanvasLayer/Panel/HBoxContainer/Label.text = " " + str(Global.gacha_tokens*100)
	
	if $CanvasLayer/gacha_screen.frame == 1:
		$CanvasLayer/no.visible = false
		$CanvasLayer/gacha_items.visible = true
		
		#lil wobble hehehe
		$CanvasLayer/gacha_items.rotation = 0
		$CanvasLayer/gacha_items.rotation = sin(t*5) / 7.5
		t += delta
		
		
	else:
		$CanvasLayer/no.visible = true
		$CanvasLayer/gacha_items.visible = false
		
	pass
	
#random int from 0 to num (including both)
func random(num):
	randomize()
	var RandomNum = randi() % (num + 1)
	return(RandomNum)

func _on_yes_pressed() -> void:
	if $CanvasLayer/gacha_screen.frame == 0:
		$CanvasLayer/gacha_screen.frame = 1
		
		Global.gacha_tokens -= 1
		$CanvasLayer/Panel/HBoxContainer/Label.text = " " + str(Global.gacha_tokens*100)

		
		#choosing random item
		if gacha_item_list.size() == 0:
			for i in range(8):
				gacha_item_list.append(i)
		
		var item_picked = random(gacha_item_list.size()-1)
		print(item_picked)
		print(gacha_item_list)
		$CanvasLayer/gacha_items.frame = gacha_item_list[item_picked]
		#gacha_item_list.remove_at(item_picked)
		Global.gacha_have[gacha_type].append(item_picked)
		
		Global.gacha_done = true
		for i in range(7):
			if !Global.gacha_have["asian"].has(i):
				Global.gacha_done = false
			if !Global.gacha_have["drink"].has(i):
				Global.gacha_done = false
			if !Global.gacha_have["pastry"].has(i):
				Global.gacha_done = false
		
		if Global.gacha_tokens > 0:
			$CanvasLayer/again.visible = true
			pass
		
	else:
		$CanvasLayer.visible = false
		
	pass # Replace with function body.

func _on_no_pressed() -> void:
	$CanvasLayer.visible = false
	pass # Replace with function body.

func _on_texture_button_pressed() -> void:
	$CanvasLayer/again.visible = false
	$CanvasLayer.visible = not $CanvasLayer.visible
	if Global.gacha_tokens > 0:
		$CanvasLayer/gacha_screen.frame = 0
		$CanvasLayer/yes.visible = true
		$CanvasLayer/broke.visible = false
	else:
		$CanvasLayer/gacha_screen.frame = 2
		$CanvasLayer/yes.visible = false
		$CanvasLayer/broke.visible = true
	print(Global.gacha_tokens)
	pass # Replace with function body.


func _on_again_pressed() -> void:
	if $CanvasLayer/gacha_screen.frame == 1:
		$CanvasLayer/gacha_screen.frame = 0
	$CanvasLayer/again.visible = false
	pass # Replace with function body.
