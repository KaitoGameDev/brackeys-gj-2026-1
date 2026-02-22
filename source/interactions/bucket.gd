extends Interactable

@onready var fruit_puzzle: FruitPuzzle = $"%FruitPuzzle"

func _on_interact():
	fruit_puzzle.empty_bucket()
