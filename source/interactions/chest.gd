extends Interactable

@export var chest_lid_object: Node3D
@export var item_container: Node3D

# the item inside the chest - if empty won't spawn anything
@export var item: PackedScene

func _on_interact():
	var lid_tween = get_tree().create_tween()
	lid_tween.tween_property(chest_lid_object, "rotation:x", deg_to_rad(-80.0), 1.0)
	
	if item != null:
		var item_ref = item.instantiate()
		item_container.add_child(item_ref)
		
		var container_tween = get_tree().create_tween()
		container_tween.tween_property(item_container, "position:y", 2.0, 2.0)
