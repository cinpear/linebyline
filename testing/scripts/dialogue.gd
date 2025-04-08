extends Node2D

"""
REMEMBER MUY IMPORTANTE CONNECT SIGNAL IN NPC TO THIS DIALOGUE SCRIPT! hopefully it works welp
if it doesn't i failed and gotta restart the entirety of this dialogue script! 
:star_struck:
ahhhhhh

things to do for each dialogue:
	SET NPC NAME AHHH
	connect signal in npc to dialogue
	set dialogue ids for char and npc
	do transfrom + px above npcs
	name each dialogue frame a number
"""

class_name Dialogue

var inZone = true
var isChatting = false

@export var npcName = ""
@export var npcMain = false
#total dialogue scripts for one npc's story
#find better var name pls and fix
@export var npcDialogueNumber = 0

@export var npcDialogueID = [1, 3, 5]
@export var charDialogueID = [2, 4]
var currentDialogueID = 0

var center
var charLeft = false
@export var pxWidthNpc = 256
@export var pxAboveNpc = 50

signal npcChatting
signal charChatting


var timer := Timer.new()
var block_timer := Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	"""
	#bc last interaction signals a char interaction of the next one, set as neg so it goes to 0 as it should
	if npcDialogueNumber > 0:
		currentDialogueID = 0
	"""
	
	position.y = -260
	pxAboveNpc = -position.y
	center = global_position.x
	$proximity.position.y = pxAboveNpc
	#Global.on_interact.connect(if_interacted)
	pass # Replace with function body.
	
	#dialogue manager setup
	if !DialogueManager.npcs.has(npcName):
		DialogueManager.npcs.append(npcName)
		print(DialogueManager.npcs)
		DialogueManager.npcs_dialogue_total[npcName] = 0
		print(DialogueManager.npcs_dialogue_total)
		DialogueManager.npcs_dialogue_current[npcName] = 0
		print(DialogueManager.npcs_dialogue_current)
		if npcMain:
			DialogueManager.main_npcs.append(npcName)
			DialogueManager.item_done[npcName] = false
	if DialogueManager.npcs.has(npcName):
		if npcDialogueNumber > DialogueManager.npcs_dialogue_total[npcName]:
			DialogueManager.npcs_dialogue_total[npcName] = npcDialogueNumber
	
	"""
	put this lower to go when the img runs
	#checking if the story item picture was taken to give gacha coin
	#if DialogueManager.npcs_dialogue_current[npcName] >= 1:
	if DialogueManager.item_done[npcName]:
		Global.gacha_tokens += 1
		pass
	"""
	
	#timer for token confirmation
	add_child(timer)
	timer.wait_time = 1
	timer.one_shot = true
	timer.connect("timeout", _on_timer_timeout)
	
	#timer for wait time between dialogue scripts
	add_child(block_timer)
	block_timer.wait_time = 3
	block_timer.one_shot = true
	block_timer.connect("timeout", _on_block_timer_timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	if inZone == true and isChatting == true:
		$"visible".visible = true
	else:
		$"visible".visible = false
		
	if center - Global.charX > 0:
		charLeft = true
	else:
		charLeft = false
		
	if npcDialogueID.has(currentDialogueID) or currentDialogueID == 999:
		isChatting = true
		$visible.position.y = 0
		if charLeft:
			$"visible/chat box".flip_h = false
			$visible.position.x = 0 + pxWidthNpc/2#center# + pxWidthNpc
		else: 
			$"visible/chat box".flip_h = true
			$visible.position.x = 0 - pxWidthNpc/2#center# - pxWidthNpc
		#emit_signal("npcChatting")
	elif charDialogueID.has(currentDialogueID):
		$visible.global_position.y = Global.charY - 400
		isChatting = true
		if !charLeft:
			$"visible/chat box".flip_h = false
			$visible.global_position.x = Global.charX + pxWidthNpc/4
		else:
			$"visible/chat box".flip_h = true
			$visible.global_position.x = Global.charX - pxWidthNpc/4
		#emit_signal("charChatting")
	else:
		isChatting = false
	
	#for the actual things inside the text box
	"""
	for i in range(npcDialogueID.size()+charDialogueID.size()):
		i += 1
		var currentImg = get_node("visible/" + str(i))
		if currentImg != null:
			if i == currentDialogueID:
				currentImg.visible = true
			else:
				currentImg.visible = false
	"""
	if currentDialogueID > 0:
		$visible/images.visible = true
		$visible/images.frame = currentDialogueID - 1
		if currentDialogueID == 999:
			$visible/images.visible = false
	else:
		$visible/images.visible = false
	
	if currentDialogueID == 999:
		$visible/token_confirmation.visible = true
	else:
		$visible/token_confirmation.visible = false
	
	pass

"""
func _on_npc_in_range() -> void:
	if inZone == false:
		inZone = true
	else:
		inZone = false
	pass # Replace with function body.


func _on_npc_char_is_left() -> void:
	if npcDialogueID.has(currentDialogueID):
		$"chat box".flip_h = false
	else:
		$"chat box".flip_h = true
	pass # Replace with function body.


func _on_npc_char_is_right() -> void:
	if npcDialogueID.has(currentDialogueID):
		$"chat box".flip_h = true
	else:
		$"chat box".flip_h = false
"""

func _on_proximity_body_entered(body: Node2D) -> void:
	if body is player:
		inZone = true

func _on_proximity_body_exited(body: Node2D) -> void:
	if body is player:
		inZone = false

#replace with npc specific signal i dont want to make this global
#wait rip i can't do that :sob:

func _on_npc_interact_char() -> void:
	#currentDialogueID += 1
	#checking if is correct dialogue sequence
	print("interacted")
	print("current dialogue" + str(DialogueManager.npcs_dialogue_current[npcName]))
	print("this dialogue number" + str(npcDialogueNumber))
	print(DialogueManager.block_interacting)
	if DialogueManager.npcs_dialogue_current[npcName] == npcDialogueNumber and !DialogueManager.block_interacting:
		#set last interacted main npc
		print("ran")
		if DialogueManager.main_npcs.has(npcName):
			DialogueManager.last_interacted_main_npc = npcName
			
		"""for testing"""
		print(DialogueManager.main_npcs)
		print(DialogueManager.last_interacted_main_npc)
		
		#if player collected story item
		if !DialogueManager.item_done[npcName]:
			#increase id of dialogue within current interaction
			if currentDialogueID != 999:
				currentDialogueID += 1
			print("good")
		else:
			#trigger the npc approval + get token visual heheh
			DialogueManager.item_done[npcName] = false
			print("bad")
			currentDialogueID = 999
			Global.gacha_tokens += 1
			timer.start()
		
		#increase id of all dialogues of current character
		if !npcDialogueID.has(currentDialogueID) and !charDialogueID.has(currentDialogueID) and currentDialogueID != 999:
			DialogueManager.npcs_dialogue_current[npcName] += 1
			if NavigationManager.load_bus:
				get_tree().change_scene_to_packed.call_deferred(NavigationManager.scene_to_load)
				Global.game_state_bus = false
				NavigationManager.load_bus = false
				DialogueManager.item_done[npcName] = false
				DialogueManager.block_interacting = false
				print("hello")
			else:
				DialogueManager.block_interacting = true
			block_timer.start()
				
	print(currentDialogueID)
	pass # Replace with function body.

"""
func if_interacted():
	if DialogueManager.interacted_npc == npcName:
		if DialogueManager.interacted_npc_number == npcDialogueNumber:
			currentDialogueID +=1
			pass
"""

func _on_timer_timeout() -> void:
	#get back to original script
	currentDialogueID = 1
	print("timer timeout")

func _on_block_timer_timeout() -> void:
	DialogueManager.block_interacting = false
