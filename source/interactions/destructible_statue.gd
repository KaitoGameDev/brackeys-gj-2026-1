extends Interactable

@export var max_health: int = 10
@export var statue_object: Node3D
@export var rubble_object: Node3D

var health = max_health;

func _on_interact():
	health -= 1;
	
	if health <= 0:
		statue_object.visible = false
		rubble_object.visible = true
