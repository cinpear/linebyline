extends Node

const scene_room = preload("res://scenes/room.tscn")
const scene_game = preload("res://scenes/game.tscn")
const scene_bus = preload("res://scenes/bus.tscn")
const scene_home = preload("res://scenes/home.tscn")
const scene_cafe = preload("res://scenes/cafe.tscn")

signal on_player_spawn

var spawn_door_tag

var scene_to_load 

var load_bus = false

func go_to_world(world_tag, destination_tag):
	match world_tag:
		"game":
			scene_to_load = scene_game
		"room":
			scene_to_load = scene_room
		"cafe":
			scene_to_load = scene_cafe
		"home":
			scene_to_load = scene_home
		
	spawn_door_tag = destination_tag
			
	if scene_to_load != null:
		#regular loading aka within locations (outside to inside a place) or going back home
		if !load_bus:
			get_tree().change_scene_to_packed.call_deferred(scene_to_load)
		#from bus stop to a place
		#loads to the bus first (constant scene, just npc changes)
		#then loads to the other location with a diff function
		else:
			get_tree().change_scene_to_packed.call_deferred(scene_bus)
			Global.game_state_bus = true

func leave_bus():
	get_tree().change_scene_to_packed.call_deferred(scene_to_load)

func spawn_player(position: Vector2):
	on_player_spawn.emit(position)
