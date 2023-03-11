extends Node

var KNIGHT_CARD: int
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func get_matched_cards(upper_row, lower_row):
	var matched_cards = []
	for i in range(len(upper_row)):
		if upper_row[i] == lower_row[i]:
			matched_cards.append(upper_row[i])
