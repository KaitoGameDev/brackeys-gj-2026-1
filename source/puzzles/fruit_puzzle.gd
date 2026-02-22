class_name FruitPuzzle
extends Node3D

@export var required_weight: int = 15
@export var label: Label3D
@export var fruit_objects: Array[Node3D]
@export var reward_container: Node3D
@export var bucket_container: Node3D

var current_weight: int = 0
var has_been_resolved: bool = false

func add_item(weight: int):
	if has_been_resolved:
		return
	
	EventBusSingleton.send_event(PlaySfxEvent.create('pickup_food'))
		
	current_weight += weight
	refresh_label()
	
	if current_weight == required_weight:
		EventBusSingleton.send_event(PlaySfxEvent.create('solved_puzzle'))
		has_been_resolved = true
		reward_container.visible = true
		bucket_container.visible = false
		

func empty_bucket():
	EventBusSingleton.send_event(PlaySfxEvent.create('empty_bucket'))
	for obj in fruit_objects:
		obj.visible = true
	current_weight = 0
	refresh_label()
	
func refresh_label():
	label.text = str(current_weight) + " / " + str(required_weight)
	
