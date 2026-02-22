extends Interactable

@onready var flower_puzzle = $"%FlowerPuzzle"

func _on_interact():
	flower_puzzle.add_to_counter(1)
	self.visible = false
