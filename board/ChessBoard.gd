extends Node2D

const TILE_SIZE = 64
var logic : Node = preload("res://logic/ChessLogic.gd").new()
var selected_piece = null

func _ready():
	draw_board()
	spawn_pieces()

func draw_board():
	for y in range(8):
		for x in range(8):
			var tile := ColorRect.new()
			tile.color = Color.WHITE if (x + y) % 2 == 0 else Color.GRAY
			tile.size = Vector2(TILE_SIZE, TILE_SIZE)
			tile.position = Vector2(x, y) * TILE_SIZE
			add_child(tile)

func spawn_pieces():
	var board_state = logic.get_board()
	for y in range(8):
		for x in range(8):
			var piece = board_state[y][x]
			if piece != "":
				var sprite := Sprite2D.new()
				sprite.texture = load("res://assets/pieces/%s.png" % piece)
				sprite.position = Vector2(x + 0.5, y + 0.5) * TILE_SIZE
				add_child(sprite)
