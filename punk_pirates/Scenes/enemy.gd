extends CharacterBody3D

@onready var target_player = $"../Player"
@onready var health_bar: ProgressBar = $SubViewport/ProgressBar
const SPEED = 3.0
const JUMP_VELOCITY = 4.5
var projectile = preload("res://objects/hurt_box.tscn")
@onready var enemy_rotation = $EnemyRotation
@onready var projectile_spawner = $EnemyRotation/ProjectileSpawner
@export var range: float = 2


# AI
@onready var nav = $NavigationAgent3D
@export var attack_radius: float = 1.5
@export var attack_cooldown: float = 2
var current_cooldown_time: float = 0

var max_health: int = 20
var health: int

func _ready() -> void:
	health = max_health
	health_bar.max_value = max_health
	update_health()

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	if (target_player == null):
		return
	if position.distance_to(target_player.position) < attack_radius:
		attack()
	
	var next_location = nav.get_next_path_position()
	var current_location = global_transform.origin
	var new_velocity = (next_location - current_location).normalized() * SPEED
	
	velocity = velocity.move_toward(new_velocity, 0.25)
	move_and_slide()
	nav.target_position = target_player.position
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
		p.scale = Vector3(range, range, range)
		p.source = position
		current_cooldown_time = attack_cooldown
	

func on_hit(source: Vector3, damage: int, knockback: float):
	health -= damage
	update_health()
	# apply knockback
	var direction: Vector3 = (position - source).normalized()
	velocity = direction * knockback
	

func update_health():
	health_bar.value = health
	# check if dead
	if (health <= 0):
		queue_free()
