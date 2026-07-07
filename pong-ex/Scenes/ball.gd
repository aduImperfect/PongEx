extends RigidBody3D

@export var forward_vector : Vector3 = -global_transform.basis.z
@export var right_vector   : Vector3 = global_transform.basis.x

@export var fVOn : float = 0.0
@export var rVOn : float = 0.0

@export var current_direction : Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fVOn = randf_range(0.0, 100.0)
	rVOn = randf_range(0.0, 100.0)
	current_direction = Vector3(0.0, 0.0, 0.0)

	if (fVOn > 33.0):
		current_direction += forward_vector
	if (rVOn < 33.0) && (current_direction.is_zero_approx() == false):
		current_direction += right_vector

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	apply_force(current_direction)


func _on_body_entered(_body: Node) -> void:
	#current_direction = current_direction.bounce(_body.get_normal())
	pass
