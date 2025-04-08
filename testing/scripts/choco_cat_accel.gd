extends CharacterBody2D

class_name player

const max_speed = 600*.75
const accel = 1500*.75
const friction = 1500

var left = false

#game stat ein global

var input = Vector2.ZERO

func _physics_process(delta):
	player_movement(delta)
	Global.charX = global_position.x
	Global.charY = global_position.y
	
	$"trophy hat".visible = Global.gacha_done

func get_input():
	input.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	if input.x < 0:
		left = true
	else:
		left = false
	input.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return input.normalized()
	
func player_movement(delta):
	input = get_input()
	
	if !Global.game_state_bus:
		if input == Vector2.ZERO:
			if velocity.length() > (friction * delta):
				velocity -= velocity.normalized() * (friction * delta)
				$AnimatedSprite2D.animation = "moving"
			else:
				velocity = Vector2.ZERO
				$AnimatedSprite2D.animation = "idle"
		else:
			velocity += (input * accel * delta)
			velocity = velocity.limit_length(max_speed)
			$AnimatedSprite2D.animation = "moving"
			
		$AnimatedSprite2D.flip_h = left
	else:
		if input != Vector2.ZERO:
			var tempx = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
			position.x += tempx * delta * accel * 0.35
			$AnimatedSprite2D.animation = "moving"
			if tempx > 0:
				$AnimatedSprite2D.flip_h = false
			else:
				$"AnimatedSprite2D".flip_h = true
		else:
			$AnimatedSprite2D.animation = "idle"
	
	move_and_slide()
	
func _ready():
	NavigationManager.on_player_spawn.connect(on_spawn)
	
func on_spawn(position:Vector2):
	global_position = position
