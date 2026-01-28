extends Node

# Singleton global pour gérer l'état du jeu

# Limites de la map (ajuster selon ton ColorRect)
# Si ColorRect à (-1000, -1000) avec taille (2000, 2000):
const MAP_BOUNDS := Rect2(-1000, -1000, 2000, 2000)

# Ou si tu veux des limites plus grandes:
# const MAP_BOUNDS := Rect2(-2000, -2000, 4000, 4000)

# État jour/nuit
enum GamePhase { DAY, NIGHT }
var current_phase: GamePhase = GamePhase.DAY
var current_day: int = 1

func _ready() -> void:
	print("Game Manager initialized")
	print("Map bounds: ", MAP_BOUNDS)

func is_within_bounds(position: Vector2) -> bool:
	return MAP_BOUNDS.has_point(position)

func clamp_to_bounds(position: Vector2) -> Vector2:
	return Vector2(
		clamp(position.x, MAP_BOUNDS.position.x, MAP_BOUNDS.end.x),
		clamp(position.y, MAP_BOUNDS.position.y, MAP_BOUNDS.end.y)
	)