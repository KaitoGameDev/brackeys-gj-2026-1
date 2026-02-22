extends Interactable

@onready var flower_puzzle = $"%FlowerPuzzle"

func _on_interact():
	EventBusSingleton.send_event(PlaySfxEvent.create('cut'))
	flower_puzzle.add_to_counter(1)
	self.visible = false
