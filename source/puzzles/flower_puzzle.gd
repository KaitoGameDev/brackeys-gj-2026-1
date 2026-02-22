class_name FlowerPuzzle
extends Node3D

@export var min_flower_amount = 5
@export var item_container: Node3D

var counter: int = 0
var has_been_resolved: bool = false

func add_to_counter(amount: int):
	if has_been_resolved:
		return
		
	counter += amount
	if counter >= min_flower_amount:
		EventBusSingleton.send_event(PlaySfxEvent.create('solved_puzzle'))
		has_been_resolved = true
		item_container.visible = true
	
