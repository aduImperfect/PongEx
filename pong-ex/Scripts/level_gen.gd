extends Node3D

const LEVEL_SCENE = preload("res://Scenes/level.tscn")

@export var xLevelCenter : float = 0.0
@export var yLevelCenter : float = 0.0

@export var levelNode : Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	xLevelCenter = 0.0
	yLevelCenter = 0.0
	PlayersHelper._set_player_info()
	_spawn_level()
	_spawn_players()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	owner.get_child(2)

func _spawn_level() -> void:
	var level_instance = LEVEL_SCENE.instantiate()
	add_child(level_instance)
	levelNode = level_instance

func _spawn_players() -> void:
	for k in PlayersHelper.numPlayers:
		var player_instance = PlayersHelper.PLAYER_SCENE.instantiate()
		player_instance.position = PlayersHelper.playersPos[k]
		player_instance.name = "Player_" + str(k)
		#Setup player input and open this code again!
		player_instance.get_child(0).player_id = k
		var playerMeshMaterial = player_instance.get_child(0).get_child(1) as MeshInstance3D
		playerMeshMaterial.material_override = load("res://Textures/Player" + str(k) + ".png")
		add_child(player_instance)
		PlayersHelper.playerNodes.append(player_instance)
