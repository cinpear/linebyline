extends Node

"""
DIALOGUE
"""

var npcs = []
#start counting on 0 pls, so 3 would mean 4 dialogue sequences
var npcs_dialogue_total = {
}
var npcs_dialogue_current = {
}

var block_interacting = false

#for sotry items
var main_npcs = []

var last_interacted_main_npc

"""OKAY REORGANIZING TIME FUN"""

#DICTIONARY GOES:
#NPC: [destination scene, 

#hmm actually i think i like have different dictionaries its just easier to remember what is what :smiley:

"""
never used this lmao
#var interacted_npc
#var interacted_npc_number
#use var interacted_scene alr declared in global.gd
"""

func singla_dialogue(interact_npc, number):
	match interact_npc:
		"testing":
			pass

#this should be it? hopefully? yay

"""
THINGS TO TAKE PICTURES OF IDK WHAT TO NAME IT
"""
#associated w/ dialogue
#each thing will come after it is mentioned in dialogue prob?

var photographed_item
var item_done = {}
var photo_items = {
	
}

signal photo_taken
