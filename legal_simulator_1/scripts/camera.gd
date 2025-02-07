extends Node3D

var target
const lerpSpeed = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target = $"../player"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = position.lerp(target.position, delta * lerpSpeed)
