extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 10
const ROTATION_SPEED = 10
@onready var mesh = $MeshInstance3D
@onready var camera = $"../Camera/Camera3D"


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction = (camera.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		mesh.rotation.y = lerp_angle(mesh.rotation.y, atan2(-velocity.x, -velocity.z), delta * ROTATION_SPEED)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	
	move_and_slide()
