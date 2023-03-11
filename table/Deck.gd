extends Node

const KNIGHT_CARD = 8
const deck_start_position = Vector2(100, 300)

var towerTopX = 400
var towerTopY = 200
var towerTopVector: Vector2
var cardSpacingX = 20
var cardSpacingY = 25
var row_to_deal: int
var card_rows = []
#var deck = []
var cardWidth = 20
var cardHeight = 64

var deck = []
var last_row_dealt = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	deck = fill_deck()
	deck.shuffle()
	draw_deck()
#	for i in (range(7)):
#		deal_row(i)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func fill_deck():
	var num_of_each_card = 10
	var num_of_knights = 4
	for i in range(1,8):
		for j in range(num_of_each_card):
			deck.append(i)
	for i in range(num_of_knights):
		deck.append(KNIGHT_CARD)
	
	return deck

func draw_deck():
	var deck_position_offset = Vector2(2,2)
	var next_card_position = deck_start_position
	for card_num in range(len(deck)-1, -1, -1):
		var cardScene = preload("res://card/card.tscn")
		var cardInstance = cardScene.instantiate()
		var newCardName = "card_" + str(card_num)
		cardInstance.name = newCardName
		cardInstance.position = next_card_position
		add_child(cardInstance)
#		cardInstance.set_frame(cardInstance.BACK)
		cardInstance.sprite.frame = cardInstance.BACK
		cardInstance.set_card_value(deck[card_num])
		next_card_position += deck_position_offset

func get_start_of_row(row: int):
	return row * (row + 1) / 2
	

func getCardDestination(row, row_index):
	var rowStartX = towerTopVector.x - ((row - .5) * cardWidth)# - (rowToDeal/2 * cardSpacingX)
	var rowStartY = towerTopVector.y + row * cardSpacingY
	var nextCardX = rowStartX + cardWidth * row_index + cardSpacingX * row_index
#	row_index += 1
#	if row_index > row:
#		row += 1
#		row_index = 0
	return Vector2(nextCardX, rowStartY)
	
	
func deal_row(row: int):
	var row_start = get_start_of_row(row)
	var cards_dealt = []
#	var row_value = 0
	for row_offset in range(row+1):
#		var current_card = row_start + row_offset
		var card_node = get_node("card_" + str(row_start + row_offset))
		if row != 0:
			card_node.flip_card()
		card_node.position = getCardDestination(row, row_offset)
		card_node.set_z_index(row)
		cards_dealt.append(card_node.get_card_value())
	card_rows.append(cards_dealt)
		

func deal_next_row():
	deal_row(last_row_dealt)
	last_row_dealt += 1
	
#		var cardScene = preload("res://card/card.tscn")
#		var cardInstance = cardScene.instantiate()
#		var newCardName = "card_" + str(current_card)
#		cardInstance.name = newCardName
#		cardInstance.position = getCardDestination(row, row_offset)
#		add_child(cardInstance)
#		cardInstance.set_card_value(deck[current_card])
#		cardInstance.set_frame(cardInstance.BACK)
##		if deck[current_card] != KNIGHT_CARD:
##			row_value += deck[current_card]
##		deck_index += 1
#	row_value = get_row_value(row)
#	return row_value
