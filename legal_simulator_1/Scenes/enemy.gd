extends Node3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var health_bar: ProgressBar = $SubViewport/ProgressBar

var max_health: int = 20
var health: int

func _ready() -> void:
	health = max_health
	health_bar.max_value = max_health
	update_health()

func _physics_process(delta: float) -> void:
	pass

func on_hit(dmg: int):
	health -= dmg
	update_health()
	print(health)

func update_health():
	health_bar.value = health
	if (health <= 0):
		queue_free()
