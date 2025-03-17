extends Node3D

var target
var y_rot: float
const lerpSpeed = 5
const rotation_lerp_speed = 10
@onready var camera = $Camera3D

@onready var smooth_target = $SmoothTarget

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target = $"../Player"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (target != null):
		position = position.lerp(target.position, delta * lerpSpeed)
		smooth_target.rotation.y = y_rot
		smooth_target.position = lerp(smooth_target.position, target.position, delta * rotation_lerp_speed)
		transform.basis = Basis(Quaternion(transform.basis).slerp(Quaternion(smooth_target.transform.basis), delta))
		camera.look_at(smooth_target.position, Vector3.UP)
	
