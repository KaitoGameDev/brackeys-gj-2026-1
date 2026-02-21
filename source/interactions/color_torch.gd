class_name ColorTorch
extends Interactable

@onready var torch_puzzle: TorchPuzzle = $"%TorchPuzzle"
@export var should_be_enabled: bool = false
@export var light_object: Node3D

var is_enabled: bool = false

func _on_interact():
	is_enabled = !is_enabled
	light_object.visible = is_enabled
	torch_puzzle.validate()
