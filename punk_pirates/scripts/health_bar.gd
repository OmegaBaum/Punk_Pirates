extends Control

var value = 0
var max_value = 0

const ANIM_SPEED = 5

@onready var progress_bar = $ProgressBar
@onready var progress_bar_white = $ProgressBarWhite


# Called when the node enters the scene tree for the first time.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress_bar.value = value
	progress_bar_white.value = lerpf(progress_bar_white.value, progress_bar.value - 2, delta * ANIM_SPEED)

func set_max_value(value):
	max_value = value
	progress_bar.max_value = max_value
	progress_bar_white.max_value = max_value
