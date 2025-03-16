extends Node3D

@export var item_to_sense = Node3D
@export var distance = 5.0

var is_active = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (position.distance_to(item_to_sense.position) < distance):
		if !is_active:
			action()
	else:
		if is_active:
			is_active = false
func action():
	is_active = true
	print("eier lecken")
