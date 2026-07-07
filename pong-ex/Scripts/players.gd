class_name PlayersHelper

const PLAYER_SCENE = preload("res://Scenes/player.tscn")

static var playerNodes : Array[Node3D] = []
static var numPlayers : int = 0

static var playersPos : Array[Vector3] = []

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

static func _set_player_info() -> void:
	numPlayers = 2
	playersPos.append(Vector3(0.0, 0.5, 20.0))
	playersPos.append(Vector3(0.0, 0.5, -20.0))
