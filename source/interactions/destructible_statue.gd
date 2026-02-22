extends Interactable

@export var max_health: int = 5
@export var statue_object: Node3D
@export var rubble_object: Node3D

var health := max_health;

func _on_interact():
	health -= 1;
	
	if health <= 0:
		EventBusSingleton.send_event(PlaySfxEvent.create('solved_puzzle'))
		statue_object.visible = false
		rubble_object.visible = true
	else:
		var sfx := 'hit_statue_{0}'.format([randi_range(1, 2)])
		EventBusSingleton.send_event(PlaySfxEvent.create(sfx))
		var tween := create_tween()
		tween.tween_property(statue_object, 'position:x', statue_object.position.x - 0.01, 0.1)
		tween.tween_property(statue_object, 'position:x', statue_object.position.x + 0.01, 0.1)
		
