extends Node2D

const KNIGHT_CARD = 8

var towerTopX = 400
var towerTopY = 200
var towerTopVector = setTowerTop(towerTopX, towerTopY)
var cardSpacingX = 20
var cardSpacingY = 20
@onready var row_to_deal = 0
@onready var next_card_in_row = 0
var deck = []
var cardWidth = 20
var cardHeight = 20
var cardsCreated = 0
var deck_index = 0



# Called when the node enters he scene tree for the first time.
func _ready():
	deck = generate_deck().shuffle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setTowerTop(towerTopX, towerTopY):
	return Vector2(towerTopX, towerTopY)
	
func getCardDestination():
	var rowStartX = towerTopVector.x - ((row_to_deal - .5) * cardWidth)# - (rowToDeal/2 * cardSpacingX)
	var rowStartY = towerTopVector.y + row_to_deal * cardSpacingY
	var nextCardX = rowStartX + cardWidth * next_card_in_row + cardSpacingX * next_card_in_row
	next_card_in_row += 1
	if next_card_in_row > row_to_deal:
		row_to_deal += 1
		next_card_in_row = 0
	return Vector2(nextCardX, rowStartY)
		

func _on_button_pressed():
	var row_value = deal_row()
	display_row_value(row_value)
	

func generate_deck():
	var num_of_each_card = 10
	var num_of_knights = 4
	for i in range(1,8):
		for j in range(num_of_each_card):
			deck.append(i)
	for i in range(num_of_knights):
		deck.append(KNIGHT_CARD)
	
	return deck

func deal_row():
	var row_value = 0
	for i in range(row_to_deal+1):
		var cardScene = preload("res://card/card.tscn")
		var cardInstance = cardScene.instantiate()
		var newCardName = "card_" + str(cardsCreated)
		cardInstance.name = newCardName
		add_child(cardInstance)
		cardInstance.set_card_value(deck[deck_index])
		if deck[deck_index] != KNIGHT_CARD:
			row_value += deck[deck_index]
		deck_index += 1
		cardInstance.position = getCardDestination()
	return row_value
		
func display_row_value(row_value):
	print("row value ", row_value)
	pass
