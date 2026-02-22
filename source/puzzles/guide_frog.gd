extends Node3D

@export var pointer: Frog
@export var targets: Array[Node3D]

var current_index: int = 0

const TWEEN_DURATION: float = 0.30
const WAIT_DURATION: float = 1.0

func _ready() -> void:
	start_cycle()

func start_cycle() -> void:
	var target = targets[current_index]
	var tween = create_tween()
	pointer.play_jump_anim()
	tween.tween_property(pointer, "global_position", target.global_position, TWEEN_DURATION)
	tween.tween_interval(WAIT_DURATION)
	tween.finished.connect(_on_cycle_finished)


func _on_cycle_finished() -> void:
	current_index = (current_index + 1) % targets.size()
	start_cycle()
