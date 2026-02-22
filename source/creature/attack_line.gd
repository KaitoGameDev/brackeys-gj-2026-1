class_name AttackLine extends Node3D
	
@export var velocity: float = -0.01


func _ready() -> void:
	for child in get_children():
		(child as Attack).on_eliminated.connect(
			func():
				child.activate()
		)
	
func _physics_process(delta: float) -> void:
	position = Vector3(position.x, position.y, position.z + (velocity * delta))
