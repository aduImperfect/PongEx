extends CharacterBody3D

# Export this variable to change it in the Inspector for each player node
@export var player_id: int = 0

@export var move_left_action: String
@export var move_right_action: String

@export var is_moving_left : bool = false
@export var is_moving_right : bool = false

@export var move_speed : float = 20.0

func _ready() -> void:
	move_left_action = "ui_left_p" + str(player_id)
	move_right_action = "ui_right_p" + str(player_id)

func _process(_delta: float) -> void:
	if Input.is_action_pressed(move_left_action):
		is_moving_left = true
	else:
		is_moving_left = false

	if Input.is_action_pressed(move_right_action):
		is_moving_right = true
	else:
		is_moving_right = false

func _physics_process(_delta: float) -> void:
	if is_moving_left:
		position.x += _delta * move_speed
	elif is_moving_right:
		position.x -= _delta * move_speed
	move_and_slide()

func _input(_event: InputEvent) -> void:
	pass
