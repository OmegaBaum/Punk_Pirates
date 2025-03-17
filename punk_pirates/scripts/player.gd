extends CharacterBody3D


const SPEED = 7.0
const JUMP_VELOCITY = 10
const ROTATION_SPEED = 10
const RANGE = 3
const ATTACK_COOLDOWN: float = 0.3

var projectile = preload("res://objects/hurt_box_friendly.tscn")

@onready var health_bar = $SubViewport/HealthBar
var max_health: int = 40
var health: int

var current_cooldown_time: float = 0
var is_attacking = false

@onready var mesh = $MeshInstance3D
@onready var camera = get_viewport().get_camera_3d().get_parent()
@onready var player_rotation = $PlayerRotation
@onready var projectile_spawner = $PlayerRotation/ProjectileSpawner
@onready var anim = $AnimationPlayer

func _ready() -> void:
	health = max_health
	health_bar.set_max_value(max_health)
	update_health()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("fire1"):
		attack()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction = (camera.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction && !is_attacking:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		mesh.rotation.y = lerp_angle(mesh.rotation.y, atan2(-velocity.x, -velocity.z), delta * ROTATION_SPEED)
		player_rotation.rotation.y = atan2(-velocity.x, -velocity.z)
		anim.play("WALK")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		if !is_attacking:
			anim.play("IDLE")
	
	if current_cooldown_time > 0:
		current_cooldown_time -= delta
	
	move_and_slide()
func attack():
	if current_cooldown_time <= 0:
		mesh.rotation.y = player_rotation.rotation.y
		var p = projectile.instantiate()
		get_parent().add_child(p)
		p.position = projectile_spawner.global_position
		p.rotation = projectile_spawner.global_rotation
		p.scale = Vector3(RANGE, RANGE, RANGE)
		p.source = position
		anim.play("ATTACK")
		is_attacking = true
		current_cooldown_time = ATTACK_COOLDOWN

func on_hit(source: Vector3, damage: int, knockback: float):
	health -= damage
	update_health()
	# apply knockback
	var direction: Vector3 = (position - source).normalized()
	velocity = direction * knockback * 5

func update_health():
	health_bar.value = health
	if (health <= 0):
		queue_free()
func attack_end():
	is_attacking = false
