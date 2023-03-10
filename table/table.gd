extends Node2D

const KNIGHT_CARD = 8

var towerTopX = 400
var towerTopY = 200
var towerTopVector = setTowerTop(towerTopX, towerTopY)
var cardSpacingX = 20
var cardSpacingY = 25
var row_to_deal: int
var deck = []
var cardWidth = 20
var cardHeight = 64
#var cardsCreated = 0
var deck_index = 0
var loss_cards = []


# Called when the node enters he scene tree for the first time.
func _ready():
	row_to_deal = 0
	deck = generate_deck()
	deck.shuffle()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func setTowerTop(towerTopX, towerTopY):
	return Vector2(towerTopX, towerTopY)
	
	
func getCardDestination(row, row_index):
	var rowStartX = towerTopVector.x - ((row - .5) * cardWidth)# - (rowToDeal/2 * cardSpacingX)
	var rowStartY = towerTopVector.y + row * cardSpacingY
	var nextCardX = rowStartX + cardWidth * row_index + cardSpacingX * row_index
#	row_index += 1
#	if row_index > row:
#		row += 1
#		row_index = 0
	return Vector2(nextCardX, rowStartY)
	

func _on_button_deal_row_pressed():
	var row_value = deal_row(row_to_deal)
	display_row_value(row_value, row_to_deal)
	row_to_deal += 1
	deck_index += row_to_deal
	

func generate_deck():
	var num_of_each_card = 10
	var num_of_knights = 4
	for i in range(1,8):
		for j in range(num_of_each_card):
			deck.append(i)
	for i in range(num_of_knights):
		deck.append(KNIGHT_CARD)
	
	return deck
	

func deal_row(row: int):
	var row_start = get_start_of_row(row)
	print("row ", row)
	print("row index ", row_start)
#	var card_in_row = 0
	var row_value = 0
	for row_offset in range(row+1):
		var current_card = row_start + row_offset
		var cardScene = preload("res://card/card.tscn")
		var cardInstance = cardScene.instantiate()
		var newCardName = "card_" + str(current_card)
		cardInstance.name = newCardName
		cardInstance.position = getCardDestination(row, row_offset)
		add_child(cardInstance)
		cardInstance.set_card_value(deck[current_card])
#		if deck[current_card] != KNIGHT_CARD:
#			row_value += deck[current_card]
#		deck_index += 1
	row_value = get_row_value(row)
	return row_value


func get_start_of_row(row: int):
	return row * (row + 1) / 2

func get_row_value(row):
	var row_value = 0
	var knight_in_row = false
	if row < 1:
		return row_value
	
	var row_start = get_start_of_row(row)
	for card in range(row + 1):
		var current_card = row_start + card
		if deck[current_card] == KNIGHT_CARD:
			knight_in_row = true
		else:
			row_value += deck[current_card]
	
	if not knight_in_row and (check_for_loss(row) == true):
		row_value = -1
	
	return row_value
		

func check_for_loss(row):
	var loss = false
	
	if row <= 1:
		return false
	
	var prev_row_start = get_start_of_row(row - 1)
	var row_start = get_start_of_row(row)
	var prev_row_cards = deck.slice(prev_row_start, prev_row_start + row)
	print("prev row", row - 1)
	print("prev row cards", prev_row_cards)
	var row_cards = deck.slice(row_start, row_start + row + 1)
	for i in range(row):
		if prev_row_cards[i] == row_cards[i]:
			loss = true
			loss_cards.append(row_start + i)
		if prev_row_cards[i] == row_cards[i + 1]:
			loss = true
			loss_cards.append(row_start + i + 1)
			
		if loss == true:
			loss_cards.append(prev_row_start + i)
	
	return false
		
func display_row_value(row_value, row):
	var row_label = Label.new()
	var init_position: Vector2 = getCardDestination(row, row)
	init_position.x += cardWidth+5
	init_position.y -= 35
	row_label.text = str(row_value)
	add_child(row_label)
	row_label.position = init_position


func _on_button_redeal_pressed():
	pass # Replace with function body.


