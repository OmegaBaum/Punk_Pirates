extends Node3D

@onready var target_player = $"../Player"
@onready var health_bar: ProgressBar = $SubViewport/ProgressBar
const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var projectile = preload("res://objects/hurt_box.tscn")
@onready var enemy_rotation = $EnemyRotation
@onready var projectile_spawner = $EnemyRotation/ProjectileSpawner

# AI
@export var range: float = 2
@export var attack_cooldown: float = 2
var current_cooldown_time: float = 0

var max_health: int = 20
var health: int

func _ready() -> void:
	health = max_health
	health_bar.max_value = max_health
	update_health()

func _physics_process(delta: float) -> void:
	if (target_player == null):
		return
	if position.distance_to(target_player.position) < range:
		attack()
	if current_cooldown_time > 0:
		current_cooldown_time -= delta

func attack():
	if current_cooldown_time <= 0:
		var direction: Vector3 = (position - target_player.position).normalized()
		enemy_rotation.rotation.y = atan2(direction.x, direction.z)
		
		var p = projectile.instantiate()
		get_parent().add_child(p)
		p.position = projectile_spawner.global_position
		p.rotation = projectile_spawner.global_rotation
		current_cooldown_time = attack_cooldown
	

func on_hit(dmg: int):
	health -= dmg
	update_health()
	print(health)

func update_health():
	health_bar.value = health
	if (health <= 0):
		queue_free()
