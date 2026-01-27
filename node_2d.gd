# node_2d.gd
# Root node - Entry point for the game

extends Node2D

func _ready():
	"""Initialize root node"""
	print("[ROOT] Game initialized")
	print("[ROOT] Game_Manager status: initialized=%s" % Game_Manager.is_initialized)
