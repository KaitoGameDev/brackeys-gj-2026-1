class_name LillyPad
extends Interactable

@onready var frog_puzzle: FrogPuzzle = $"%FrogPuzzle"
@export var pointer: Node3D
@export var pointer_target: Node3D
@export var character: String

func _on_interact():
	frog_puzzle.add_char_to_buffer(character)
	
	var pointer_tween = get_tree().create_tween()
	pointer_tween.tween_property(pointer, "global_position", pointer_target.global_position, 0.3)
	
