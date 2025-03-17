extends Area3D

@export var y_rotation: float 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_entered(area: Area3D) -> void:
	if area.is_in_group("player"):
		get_viewport().get_camera_3d().get_parent().y_rot = y_rotation
