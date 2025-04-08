extends Node

#first time interacting will get rid yes yes
var inputPrompts = true

var charX
var charY

var game_state_bus = false

var gacha_tokens = 0
var gacha_have = {
	"asian": [],
	"drink": [],
	"pastry": []
}
var gacha_done = false

#for interacting
signal on_interact
var interacted_scene
var interaced_node
func signal_interact(interacted_Node, interacted_Scene):
	interacted_scene = interacted_Scene
	interaced_node = interacted_Node
	on_interact.emit()
	pass
