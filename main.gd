extends Node

func _ready():
	var board = preload("res://board/ChessBoard.tscn").instantiate()
	add_child(board)
