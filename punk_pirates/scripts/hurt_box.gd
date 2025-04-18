extends Area3D

# stats
@export var damage: int = 5
@export var knockback = 7

@export var friendly: bool = false

var source: Vector3 = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("SLASH")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	queue_free()


func _on_area_entered(hitbox: Area3D) -> void:
	if friendly && hitbox.is_in_group("friendly"):
		return
	if !friendly && !hitbox.is_in_group("friendly"):
		return
	if hitbox == null || hitbox.owner == null:
		return
	
	if hitbox.owner.has_method("on_hit"):
		hitbox.owner.on_hit(source, damage, knockback)
		
