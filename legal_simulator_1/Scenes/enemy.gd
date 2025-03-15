extends Node3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var health: int = 20

func _physics_process(delta: float) -> void:
	pass

func on_hit(dmg: int):
	health -= dmg
	if (health <= 0):
		queue_free()
	print(health)
