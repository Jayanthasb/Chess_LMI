extends Node2D

const TILE_SIZE = 64
var logic: Node = preload("res://logic/ChessLogic.gd").new()
var selected_pos: Vector2i = Vector2i(-1, -1)
var sprite_grid = []
var highlight_rect: ColorRect = null

func _ready():
	draw_board()
	spawn_pieces()

func draw_board():
	for y in range(8):
		for x in range(8):
			var tile = ColorRect.new()
			tile.color = Color.WHITE if (x + y) % 2 == 0 else Color.GRAY
			tile.size = Vector2(TILE_SIZE, TILE_SIZE)
			tile.position = Vector2(x, y) * TILE_SIZE
			add_child(tile)

	# Prepare highlight square
	highlight_rect = ColorRect.new()
	highlight_rect.color = Color(0, 1, 0, 0.4)  # green with 40% opacity
	highlight_rect.size = Vector2(TILE_SIZE, TILE_SIZE)
	highlight_rect.visible = false
	add_child(highlight_rect)

func spawn_pieces():
	# Clean up old sprites
	for row in sprite_grid:
		for sprite in row:
			if sprite:
				remove_child(sprite)
	sprite_grid.clear()

	var board_state = logic.get_board()
	for y in range(8):
		var row = []
		for x in range(8):
			var piece = board_state[y][x]
			var sprite = null
			if piece != "":
				sprite = Sprite2D.new()
				sprite.texture = load("res://assets/pieces/%s.png" % piece)
				sprite.position = Vector2(x + 0.5, y + 0.5) * TILE_SIZE
				sprite.scale = Vector2(1, 1)
				add_child(sprite)
			row.append(sprite)
		sprite_grid.append(row)

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		var x = int(event.position.x / TILE_SIZE)
		var y = int(event.position.y / TILE_SIZE)
		if x < 0 or x > 7 or y < 0 or y > 7:
			return
		handle_click(x, y)

func handle_click(x, y):
	var board = logic.get_board()
	var clicked = Vector2i(x, y)

	if selected_pos == Vector2i(-1, -1):
		# Select if a piece is present
		if board[y][x] != "":
			selected_pos = clicked
			highlight_rect.position = clicked * TILE_SIZE
			highlight_rect.visible = true
			print("Selected:", board[y][x], "at", selected_pos)
	else:
		if selected_pos == clicked:
			# Deselect
			print("Deselected.")
			selected_pos = Vector2i(-1, -1)
			highlight_rect.visible = false
		else:
			# Move piece
			logic.make_move(selected_pos, clicked)
			selected_pos = Vector2i(-1, -1)
			highlight_rect.visible = false
			spawn_pieces()
