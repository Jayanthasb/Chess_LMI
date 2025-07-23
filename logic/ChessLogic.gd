extends Node

var board = [
	["br", "bn", "bb", "bq", "bk", "bb", "bn", "br"],
	["bp", "bp", "bp", "bp", "bp", "bp", "bp", "bp"],
	["", "", "", "", "", "", "", ""],
	["", "", "", "", "", "", "", ""],
	["", "", "", "", "", "", "", ""],
	["", "", "", "", "", "", "", ""],
	["wp", "wp", "wp", "wp", "wp", "wp", "wp", "wp"],
	["wr", "wn", "wb", "wq", "wk", "wb", "wn", "wr"]
]

func get_board():
	return board

func make_move(from: Vector2i, to: Vector2i):
	var piece = board[from.y][from.x]
	board[to.y][to.x] = piece
	board[from.y][from.x] = ""
