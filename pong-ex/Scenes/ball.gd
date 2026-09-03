extends RigidBody3D

@export var forward_vector : Vector3 = -transform.basis.z
@export var right_vector   : Vector3 = transform.basis.x

@export var fVOn : float = 0.0
@export var rVOn : float = 0.0

@export var current_direction : Vector3
@export var force_multiplier : float = 0
@export var dirPlayer : float = 0.0
@export var currDirX : bool = false
@export var currDirZ : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fVOn = randf_range(10.0, 50.0)
	rVOn = randf_range(10.0, 50.0)
	dirPlayer = randf_range(20.0, 100.0)
	current_direction = Vector3(0.0, 0.0, 0.0)
	force_multiplier = 5.0

	if (fVOn > 33.0):
		current_direction += roundf((50.0 - dirPlayer)/50.0) * forward_vector
	elif (rVOn < 33.0):
		current_direction += roundf((50.0 - dirPlayer)/50.0) * right_vector

	if absf(current_direction.x < 0.5) && absf(current_direction.z < 0.5):
		currDirX = bool(randi_range(0, 1))
		currDirZ = bool(randi_range(0, 1))
		var valX = -0.5
		if currDirX:
			valX = 0.5
		var valZ = -0.5
		if currDirZ:
			valZ = 0.5
		current_direction += Vector3(valX, 0.0, valZ)

	current_direction.y = 0.0

	apply_impulse(current_direction * force_multiplier)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if absf(position.z) > 21.0:
		position.x = 0.0
		position.z = 0.0
		linear_velocity.x = 0.0
		linear_velocity.y = 0.0
		linear_velocity.z = 0.0
		apply_impulse(current_direction * force_multiplier)

func _physics_process(_delta: float) -> void:
	pass

func _on_body_entered(_body: Node) -> void:
	#print("Collided with: ", _body.owner.name)
	pass

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	if state.get_contact_count() > 0:
		var contact_collider = state.get_contact_collider_object(0) as Node3D
		if contact_collider.owner.name.contains("Ground"):
			return

		var contact_position = state.get_contact_collider_position(0)
		var contact_normal = state.get_contact_local_normal(0)
		print("Colliding at: ", contact_position)
		current_direction = current_direction.bounce(contact_normal)

		if linear_velocity.length() > 10.0:
			return

		apply_impulse(current_direction * force_multiplier)
