extends Interactable

@export var buried_item: PackedScene
@export var item_container: Node3D
@export var area_model: Node3D

func _on_interact():
	area_model.visible = false
	if buried_item != null:
		EventBusSingleton.send_event(PlaySfxEvent.create('solved_puzzle'))
		var item_ref = buried_item.instantiate()
		
		item_container.add_child(item_ref)
		
		var container_tween = get_tree().create_tween()
		container_tween.tween_property(item_container, "position:y", 0.8, 2.0)
	else:
		EventBusSingleton.send_event(PlaySfxEvent.create('digging'))
