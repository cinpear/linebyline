extends Node2D


var point1 : Vector2 = Vector2(0, 0)
var width : int = 15
var color : Color = rgb255(102,184,254,255)

var _point2 : Vector2

var lines = []
var current_line = []

var sizes = {
	7: {},
	11: {},
	15: {},
	20: {},
	25: {},
	35: {}
}

var within_bounds = false

func _process(_delta):
	var mouse_position = get_viewport().get_mouse_position()
	if Input.is_mouse_button_pressed( 1 ) and within_bounds:
		if current_line.is_empty():
			current_line.push_back(mouse_position)
		else:
			if mouse_position != current_line.back():
				current_line.push_back(mouse_position)
	else:
		if not current_line.is_empty():
			"""
			if !sizes[width].has(color):
				sizes[width][color] = []
			sizes[width][color].push_back(current_line)
			"""
			
			lines.push_back([current_line, color, width])
				
			#lines.push_back(current_line)
			current_line = []
	queue_redraw()


# Called when the node enters the scene tree for the first time.
func _ready():
	lines = []
	pass # Replace with function body.

func my_draw_polyline(line: Array, col: Color, size: int):
	if line.is_empty():
		pass
	if len(line) > 1:
		draw_polyline(line, col, size * 2)
	else:
		draw_circle(line.back(), size, col)

func _draw():
	#for line in lines:
	#	my_draw_polyline(line)
	"""
	for size in sizes:
		for col in sizes[size]:
			for line in sizes[size][col]:
				my_draw_polyline(line, col, size)
	"""
	
	for line in lines:
		my_draw_polyline(line[0], line[1], line[2])
	
	if not current_line.is_empty():
		my_draw_polyline(current_line, color, width)


func _on_area_2d_mouse_entered() -> void:
	within_bounds = true
	pass # Replace with function body.

func _on_area_2d_mouse_exited() -> void:
	within_bounds = false
	pass # Replace with function body.

func rgb255(r, g, b, a):
	return Color(r/255.0, g/255.0, b/255.0, a/255.0)

func _on_blue_pressed() -> void:
	color = rgb255(102,184,254,255)
	pass # Replace with function body.

func _on_yellow_pressed() -> void:
	color = rgb255(255,216,148,255)
	pass # Replace with function body.

func _on_red_pressed() -> void:
	color = rgb255(255,152,158,255)
	pass # Replace with function body.

func _on_1_pressed() -> void:
	width = 7
	pass # Replace with function body.

func _on_2_pressed() -> void:
	width = 11
	pass # Replace with function body.

func _on_3_pressed() -> void:
	width = 15
	pass # Replace with function body.

func _on_4_pressed() -> void:
	width = 20
	pass # Replace with function body.

func _on_5_pressed() -> void:
	width = 25
	pass # Replace with function body.

func _on_6_pressed() -> void:
	width = 35
	pass # Replace with function body.

func _on_eraser_pressed() -> void:
	color = rgb255( 255, 255, 255, 255)
	pass # Replace with function body.


func _on_check_pressed() -> void:
	lines = []
	pass # Replace with function body.
